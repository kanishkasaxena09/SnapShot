# Authentication Module Review

**Scope:** `lib/features/auth/**`, `lib/core/router/app_router.dart`, `lib/main.dart`, `lib/config/env.dart`, `lib/core/storage/local_storage.dart`, `lib/core/utils/validators.dart`, `pubspec.yaml`.

**Reviewed against:** architecture, Riverpod, GoRouter, Supabase, folder structure, naming, memory leaks, async issues, validation, security, exception handling, performance, testing.

**Verification:** `flutter analyze` — 0 errors, 0 warnings (330 info-level baseline). No auth unit/widget tests exist.

---

## Executive Summary

The module has **two complete, parallel authentication stacks**:

1. **Supabase / clean-architecture stack** (production path):
   `data/auth_service.dart` → `data/datasources/supabase_auth_data_source(_impl).dart` → `data/repositories/auth_repository_impl.dart` → `domain/**` → `providers/**` → `presentation/controllers/auth_controller.dart`.

2. **Legacy in-memory / Firebase-stub stack** (UI demo remnants):
   `data/datasources/auth_local_datasource_impl.dart`, `auth_remote_datasource_impl.dart`, `user_local_datasource.dart`, `user_remote_datasource.dart`, `presentation/providers/auth_provider.dart`, `onboarding_provider.dart`, `profile_setup_provider.dart`.

The **wired UI runs on stack (1)** for register/login/splash/routing, but **several screens still run on stack (2)** (forgot-password, OTP, all onboarding steps, and the social-login buttons on login/register — the latter call Firebase stubs that throw `UnimplementedError`). Meanwhile `AuthController` — the intended state owner of stack (1) — is **dead code** (nothing consumes `authControllerProvider`).

This split causes duplicated providers (two `currentUserProvider`, two `auth_provider.dart`, two `auth_state.dart`), duplicated profile-write logic, two error vocabularies, and three overlapping user models. Everything below is ordered by the severity of the impact on a production release.

---

## Findings

### 1. Architecture

| Severity | Finding |
|---|---|
| **Critical** | Two parallel auth stacks (see above). Screens, providers, and the router are split between them, so behavior diverges (e.g. forgot-password "succeeds" via an in-memory no-op while login hits real Supabase). |
| **High** | `AuthController` is dead code. `authControllerProvider` is referenced only by its own definition (`providers/auth_controller_provider.dart:16`, `presentation/controllers/auth_controller.dart:13`). Screens call `AuthService` directly, so the `SignUp`/`SignIn` usecase + `AuthFailure` + `SignUpResult.emailVerificationRequired` flow is never exercised by the UI. |
| **High** | Duplicate profile-write logic with different behavior: `AuthService._createProfileIfAbsent` (`auth_service.dart:66`) writes the full schema (`id, full_name, username, avatar_url, bio, created_at`, `upsert` + `ignoreDuplicates`) while `SupabaseAuthDataSourceImpl.upsertProfile` (`supabase_auth_data_source_impl.dart:59`) writes only `id, full_name, username, avatar_url` with a plain `upsert`. Both are reachable (register screen → service; `currentUserProvider` → repository). |
| **Medium** | Screens bypass the repository/usecase layer, so email-confirmation handling is ad-hoc (`response.session == null` in `register_screen.dart:57`) instead of using `SignUpResult.emailVerificationRequired`. |
| **Medium** | Three overlapping user models: `AuthUser` (new), `UserEntity` (legacy), `UserModel` (legacy JSON). Two distinct `AuthState` concepts (domain Freezed vs Supabase). |
| **Low** | Usecase classes (`sign_up.dart`, `sign_in.dart`, …) are thin pass-through wrappers; acceptable for clean architecture but currently not exercised end-to-end. |

### 2. Riverpod

| Severity | Finding |
|---|---|
| **High** | **Duplicate provider names**: `currentUserProvider` exists in `features/auth/providers/auth_provider.dart` (`StreamProvider<AuthUser?>`) **and** `features/auth/presentation/providers/auth_provider.dart` (`Provider<UserEntity?>`). `profile_setup_screen.dart:32` reads the *legacy* one; the router reads `authStateProvider`. Silent collision — easy to bind the wrong one. |
| **Medium** | The stream chain `authStateProvider → currentSessionProvider → currentUserProvider` re-emits on every auth event (`TOKEN_REFRESHED`, `USER_UPDATED`, …), and `AuthRepositoryImpl.authStateChanges` (`auth_repository_impl.dart:112`) runs `fetchProfile` per event (see Performance). |
| **Medium** | `AuthController.build()` both `ref.listen(currentUserProvider)` and `await getCurrentUser()` (`auth_controller.dart:16-38`) — two sources of truth seeding the same state. |
| **Low** | `isAuthenticatedProvider` (`auth_provider.dart:60`) is unused — the router reads `authStateProvider` directly. |
| **Good** | Providers are stream-derived and auto-update; `ref.listen` is scoped/disposed correctly; no hand-rolled `StreamController`s. |

### 3. GoRouter

| Severity | Finding |
|---|---|
| **Good** | Auth-gated `redirect` implemented (`app_router.dart:108`): guest allowlist (`/login`, `/register`, `/forgot-password`, `/otp-verification`), no redirect while session is still resolving (`authState == null` → `null`), and logout/token-expiry re-evaluates redirect via `refreshListenable`. |
| **Medium** | `_AuthRefreshNotifier.authState` getter (`app_router.dart:80`) is dead code referencing the legacy in-memory provider. |
| **Low** | `debugLogDiagnostics: true` (`app_router.dart:93`) should be gated to debug builds. |
| **Note** | Router file is a single monolithic 552-line route table (outside auth scope, but worth splitting). |

### 4. Supabase

| Severity | Finding |
|---|---|
| **High (security)** | Session tokens (including refresh token) are persisted via `SharedPreferencesLocalStorage` (`main.dart`). SharedPreferences is **not** secure storage on device. `flutter_secure_storage` is already a dependency and should back the session via a custom `LocalStorage`. |
| **Medium** | Rollback on profile-write failure is inconsistent: `AuthService.signUp` best-effort calls `_auth.admin.deleteUser` (`auth_service.dart:34`) which 403s without a service-role key (harmless, logged); the repository path (`auth_repository_impl.dart:41`) performs no rollback at all. |
| **Medium** | Profile write is duplicated and divergent (see Architecture). `upsertProfile` never sets `created_at`; `AuthService` does. |
| **Low** | `fetchProfile` is called on every auth-state event, including token refreshes. |
| **Low** | `Env` values are placeholders; the Supabase **anon key is safe to ship**, but the **service-role key must never be shipped** (it is not). |
| **Note (server-side)** | `profiles` RLS policies + the FK/PK on `id` must exist in the database; the client cannot enforce this. |

### 5. Folder structure & naming

| Severity | Finding |
|---|---|
| **High** | Two files named `auth_provider.dart` (`providers/` and `presentation/providers/`) and two `auth_state` concepts (`domain/entities/auth_state.dart` vs Supabase `AuthState`), requiring `as supabase_auth` aliasing in `login_screen.dart` and `register_screen.dart`. |
| **High** | Dead legacy/Firebase-stub files remain: `auth_remote_datasource_impl.dart`, `user_remote_datasource.dart`, `user_local_datasource.dart`, `auth_local_datasource_impl.dart`, `data/models/user_model.*`. |
| **Medium** | `AuthService` (data layer) and `SupabaseAuthDataSource` (data layer) both wrap the GoTrue client with overlapping methods. |
| **Good** | Domain/data/presentation separation for the new stack is clean and consistent. |

### 6. Memory leaks

| Severity | Finding |
|---|---|
| **Good** | `AnimationController` disposed (`splash_screen.dart`), `Timer` cancelled (`otp_verification_screen.dart:45`), all `TextEditingController`s disposed, `ref.listen` callbacks are auto-disposed with their widgets. |
| **Medium** | OTP auto-send is fire-and-forget: `ref.read(authProvider.notifier).sendOtp(...)` (`otp_verification_screen.dart:38-40`) is an unawaited future with no `try/catch` — a throw becomes an unhandled async error. |
| **Low** | Legacy `AuthNotifier._checkAuthStatus()` runs from the constructor as an unawaited async (`presentation/providers/auth_provider.dart:18`). |

### 7. Async issues

| Severity | Finding |
|---|---|
| **Medium** | Register/login catch `AuthException` + generic but call `AuthService` directly; a `PostgrestException` (profile write) or unexpected error surfaces as "Something went wrong" with no differentiation even though the account may already exist. |
| **Medium** | `currentUserProvider` yields `null` on cold start before `INITIAL_SESSION` (inherent to async recovery); consumers must treat `AsyncLoading` as "unknown", not "signed out". |
| **Low** | Splash navigates via `context.go` inside `ref.listen` per emission — safe (guarded by `mounted`, widget unmounts after first navigation), just slightly redundant. |

### 8. Validation

| Severity | Finding |
|---|---|
| **Good** | `Validators.email / password / confirmPassword / required` are applied on register and login; submit is blocked until the form validates. |
| **Medium** | Password policy (8+, upper, lower, digit, special) is stricter than Supabase's default (6+). Fine as long as the server policy matches; otherwise users see a conflicting "weak password" rejection. |
| **Medium** | The register screen collects only a name — the `username` column is never populated; no uniqueness check exists. |
| **Low** | Email regex is pragmatic, not RFC-strict (acceptable); OTP validates only length. |

### 9. Security

| Severity | Finding |
|---|---|
| **High** | Session/refresh tokens in SharedPreferences (see Supabase). Move to `flutter_secure_storage`. |
| **Medium** | Social-login buttons (Google/GitHub on login + register) call the Firebase stubs that throw `UnimplementedError` → the `AuthNotifier` swallows it into `AuthState.error` and the UI shows a raw "Firebase not configured…" snackbar. Functionally dead UI. |
| **Low** | `debugLogDiagnostics: true` on the router leaks route logs in release builds. |
| **Good** | No secrets logged; passwords never stored or logged; no service-role key in the client; tokens not included in app logs. |

### 10. Exception handling

| Severity | Finding |
|---|---|
| **Medium** | Two error vocabularies: typed `AuthFailure` (domain) vs raw `AuthException`/`PostgrestException` (screens). `authFailureFrom` (`auth_failure_mapper.dart`) switches on `error.code`, but many GoTrue errors have a null code → falls through to `AuthFailure.unknown(message)`, so the typed failures are largely unused. |
| **Medium** | Rollback is inconsistent across the two signup paths (see Supabase). |
| **Low** | `_friendlyAuthMessage` string-matching is duplicated in `register_screen.dart:92` and `login_screen.dart:92` and is brittle to server message changes; prefer mapped `AuthFailure` codes. |

### 11. Performance

| Severity | Finding |
|---|---|
| **Medium** | `AuthRepositoryImpl.authStateChanges` (`auth_repository_impl.dart:112`) calls `fetchProfile` on **every** auth event — every token refresh (~hourly, and on each app foreground/restore) triggers a `profiles` network read. Refetch only when the `user.id` changes. |
| **Low** | Hive opens 6 boxes at startup regardless of usage (`local_storage.dart:23-30`) — app-wide, out of auth scope. |

### 12. Testing

| Severity | Finding |
|---|---|
| **High** | No auth tests. Only `test/widget_test.dart` exists. `mocktail` is available but unused. Missing: unit tests for `authFailureFrom`, `AuthService.signUp` (dedup/rollback), `AuthRepositoryImpl`; widget tests for register/login validation, error display, and router redirect (guest vs authenticated, logout redirect). |

---

## Consolidated Issues

| # | Issue | Severity | Area |
|---|---|---|---|
| 1 | Two parallel auth stacks; screens/router split across them | Critical | Architecture |
| 2 | `AuthController` dead code — usecase/failure flow unused | High | Architecture/Riverpod |
| 3 | Duplicate profile-write logic with divergent schemas | High | Architecture/Supabase |
| 4 | Duplicate `currentUserProvider` + two `auth_provider.dart`/`auth_state.dart` | High | Naming |
| 5 | Legacy Firebase-stub + in-memory datasources remain (dead or wired) | High | Structure |
| 6 | Session tokens in SharedPreferences (should be secure storage) | High | Security |
| 7 | No auth tests | High | Testing |
| 8 | Per-event `fetchProfile` on auth stream | Medium | Performance |
| 9 | Social login buttons wired to throwing stubs | Medium | Security/UX |
| 10 | Two error vocabularies; typed `AuthFailure` unused by UI | Medium | Exceptions |
| 11 | Inconsistent rollback across signup paths | Medium | Supabase |
| 12 | OTP auto-send unawaited, unhandled | Medium | Async/Leaks |
| 13 | `_friendlyAuthMessage` duplicated string matching | Low | Exceptions |
| 14 | `debugLogDiagnostics` not gated | Low | Security/GoRouter |
| 15 | `_AuthRefreshNotifier.authState` dead getter | Low | GoRouter |
| 16 | Password policy stricter than server default | Low | Validation |
| 17 | `username` never collected at signup | Low | Validation |

---

## Refactor Plan (prioritized)

**Phase 1 — Delete dead code (safe, high clarity)**
- Remove `auth_remote_datasource_impl.dart`, `user_remote_datasource.dart`, `user_local_datasource.dart`, `auth_local_datasource_impl.dart`, `data/models/user_model.*`, and the legacy `presentation/providers/auth_provider.dart` + `profile_setup_provider.dart`/`onboarding_provider.dart` **after** migrating their remaining consumers (below).
- Remove `_AuthRefreshNotifier.authState` dead getter; gate `debugLogDiagnostics` with `kDebugMode`.

**Phase 2 — Collapse to one auth path**
- Make `AuthService` (or the repository — pick one) the single data entry point. Recommended: keep the clean-architecture chain (`SupabaseAuthDataSource → AuthRepositoryImpl → usecases`) as the only path; delete `AuthService` OR fold its profile logic into `SupabaseAuthDataSourceImpl`.
- Wire `AuthController` into the screens (register/login/forgot-password/OTP) and the router, then delete the legacy providers entirely.

**Phase 3 — Single profile-write source**
- One `upsertProfile` (full schema: `id, full_name, username, avatar_url, bio, created_at`) using `upsert(onConflict: 'id', ignoreDuplicates: true)`; delete `AuthService._createProfileIfAbsent`.

**Phase 4 — Security**
- Back session persistence with `flutter_secure_storage` via a custom `LocalStorage` passed to `Supabase.initialize`.

**Phase 5 — Correctness**
- Unify error handling on `AuthFailure`; surface `emailNotVerified` and profile-write failures distinctly.
- Refetch profile only when `user.id` changes in `authStateChanges`.
- Await/catch the OTP auto-send.
- Add `username` field + uniqueness validation if usernames are product-required; align password policy with server.

**Phase 6 — Tests**
- Unit: `authFailureFrom`, `AuthRepositoryImpl`, profile dedup/rollback.
- Widget: register/login validation + error display; router redirect matrix (guest/auth, logout redirect).

---

## Conclusion

The **new clean-architecture Supabase stack is sound**: layered, stream-driven, correctly wired into routing and persistence. The primary risk is that it coexists with a parallel legacy stack that is still partially wired (forgot-password, OTP, onboarding, social buttons) and a dead `AuthController`. Removing the legacy stack and consolidating on one path (Phases 1–2), plus moving session tokens to secure storage (Phase 4), are the highest-value changes for production readiness.

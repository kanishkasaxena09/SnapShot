# Snapshot — Architecture & Supabase Auth Integration Analysis

Read-only audit of the codebase. No code was modified to produce this report.

**App:** Snapshot — AI-powered Tech Super App (Flutter)
**Root:** `D:\RBMI\B.Tech\projects\flutter\Snapshot`
**Analysis date:** 2026-08-02
**Status:** Awaiting user approval before any code changes.

---

## 1. Project Overview

- **227 Dart files** in `lib/`, 12 features, ~550-line GoRouter config, Material 3, responsive UI.
- **State:** Riverpod 2 (classic providers + `StateNotifier`; `riverpod_annotation` present but generators unused).
- **Routing:** go_router 16.3 (resolved) with a `ShellRoute` bottom-nav scaffold.
- **Backend:** Supabase (supabase_flutter 2.16.0) initialized at startup; a legacy custom-JWT Dio layer still exists.
- **Firebase:** packages removed for local UI-only runs, but Android Gradle + `google-services.json` + `lib/firebase_options.dart` leftovers remain.
- **Not a git repository** (no `.git`).

---

## 2. Project Structure

```
lib/
├── main.dart                  # Env.init + Supabase.initialize + LocalStorage.init + ProviderScope
├── app.dart                   # MaterialApp.router, theme, l10n delegates
├── firebase_options.dart      # LEFTOVER — unreferenced anywhere in lib
├── config/
│   └── env.dart               # Env (dev/staging/prod) — baseUrl, firebaseApiKey, openAIApiKey, supabaseUrl, supabaseAnonKey
├── core/                      # 52 files
│   ├── constants/             # app_constants, api_constants
│   ├── error/                 # exceptions.dart, failures.dart (freezed 3 sealed), logging? 
│   ├── extensions/            # extensions.dart (Freezed 3 pattern helpers)
│   ├── l10n/                  # app_localizations.dart (hand-rolled map, NO ARB files)
│   ├── network/               # api_client.dart, dio_interceptors.dart, network_info.dart
│   ├── providers/             # e.g. id_set_notifier.dart, theme_provider etc.
│   ├── router/                # app_router.dart (routerProvider), route_names.dart
│   ├── storage/               # local_storage.dart, hive_boxes.dart, storage.dart
│   ├── theme/                 # app_colors, app_spacing, app_theme, app_typography, theme.dart
│   ├── utils/                 # validators.dart etc.
│   └── widgets/               # shared widgets
├── features/                  # 12 feature modules, feature-first clean architecture
│   ├── auth/            (40 files)   ← focus of this audit
│   ├── home/            (18)
│   ├── learning/        (21)
│   ├── jobs/            (16)
│   ├── skill_analyzer/  (16)
│   ├── ai_assistant/    (14)
│   ├── profile/         (12)
│   ├── ai_tools/        ( 9)
│   ├── explore/         ( 8)
│   ├── github/          ( 8)
│   ├── project_hub/     ( 8)
│   └── more/            ( 1)
└── shared/                     # EMPTY (models/providers/services/widgets subdirs, 0 files)
test/
  └── widget_test.dart          # stub — no active assertions
```

Each feature follows `data/ | domain/ | presentation/` layers. `core/` holds cross-cutting concerns. `lib/shared/` is reserved but empty.

---

## 3. Dependencies (pubspec.yaml)

**Runtime:**
- State: `flutter_riverpod ^2.6.1`, `riverpod_annotation ^2.6.1`
- Routing: `go_router ^16.0.0` (resolved 16.3.0)
- Backend: `supabase_flutter ^2.9.1` (resolved 2.16.0)
- Networking: `dio ^5.9.0`, `connectivity_plus ^6.1.3`
- Serialization: `freezed_annotation ^3.1.0`, `json_annotation ^4.9.0`
- Local storage: `hive ^2.2.3`, `hive_flutter ^1.1.0`, `flutter_secure_storage ^9.2.4`
- UI: `google_fonts`, `cached_network_image`, `flutter_svg`, `lottie`, `flutter_animate`, `responsive_framework`, `shimmer`, `flutter_staggered_animations`
- Charts: `fl_chart ^0.70.2`
- Utils: `intl`, `url_launcher`, `share_plus`, `path_provider`, `uuid`, `image_picker`, `flutter_cache_manager`, `font_awesome_flutter`
- Codegen runtime: `freezed ^3.1.0`, `json_serializable ^6.9.2`, `build_runner ^2.4.14`

**Dev:** `flutter_test`, `flutter_lints ^6.0.0`, `mocktail ^1.0.4`

**Notable:**
- **No Firebase packages** (comment: "removed for local UI-only runs").
- **freezed 3.x** — uses new `sealed class` syntax; pattern-extension helpers added in `core/extensions/`.
- SDK constraint `^3.12.2`.
- Assets declared (`assets/images|icons|lottie|svg/`) but **all asset directories are empty**; fonts block commented out.

**Installed plugins** (from `.flutter-plugins-dependencies`): app_links, connectivity_plus, flutter_secure_storage, image_picker, path_provider, share_plus, shared_preferences, sqflite, url_launcher. (supabase_flutter is pure Dart — no native plugin.)

---

## 4. State Management (Riverpod)

- `main.dart` wraps `SnapshotApp()` in `ProviderScope`.
- Riverpod is used pervasively across features (providers, `ConsumerWidget`, `ConsumerStatefulWidget`).
- Classic providers dominate: `Provider`, `StreamProvider`, `StateNotifierProvider`, plus `ref.watch`/`ref.listen`.
- Generator annotations exist but generated `.g.dart`/`.freezed.dart` patterns for providers (`riverpod_generator`) are not applied.

**Auth providers (two parallel files — important):**

1. **New** — `lib/features/auth/providers/auth_provider.dart` (Supabase-native, consolidated)
   - `supabaseClientProvider` → `Provider<SupabaseClient>` (from `Supabase.instance.client`; single source of the client)
   - `authServiceProvider` → `Provider<AuthService>` (built on `supabaseClientProvider`)
   - `authStateProvider` → `StreamProvider<AuthState>` over `authService.authStateChanges` (raw auth events)
   - `currentSessionProvider` → `StreamProvider<Session?>` (live session, seeded from persisted session)
   - `currentUserProvider` → `StreamProvider<AuthUser?>` (live domain user via repository; `null` when signed out)
   - `isAuthenticatedProvider` → `Provider<bool>` (derived from `currentUserProvider`)
   - Dependency chain: `supabaseClientProvider` → `authDataSourceProvider` → `authRepositoryProvider` → usecase providers → `currentUserProvider`

2. **Legacy** — `lib/features/auth/presentation/providers/auth_provider.dart` (in-memory/local)
   - `authDataSourceProvider` → `AuthLocalDataSourceImpl` (in-memory map!)
   - `AuthNotifier` (`StateNotifier<AuthState>`) with signIn/signUp/social/OTP/onboarding methods
   - `authProvider` (`StateNotifierProvider<AuthNotifier, AuthState>`) — **drives the router**
   - `currentUserProvider` (`Provider<UserEntity?>`, uses `whenOrNull`)
   - `AuthRemoteDataSourceImpl` is a **stub** that throws `UnimplementedError` for everything ("Firebase not configured").

The **same file path/name collision** is resolved in `register_screen.dart` with the import alias `supabase_auth` for the new providers file.

---

## 5. Routing (GoRouter)

- `routerProvider` in `lib/core/router/app_router.dart`; `MaterialApp.router` in `app.dart`.
- `_AuthRefreshNotifier` (ChangeNotifier) + `ref.listen(authProvider, ...)` refresh the router when auth state changes.
- **Auth redirect is disabled:** `redirect: (context, state) => return null; // Auth bypassed for now`.
- `initialLocation: RouteNames.home`.
- Auth flow routes: splash, login, register, forgot-password, otp-verification, onboarding + 7 onboarding step routes.
- ShellRoute with 5 bottom-nav tabs (Home, Jobs, Saved, More, Profile).
- 40+ standalone routes (jobs, github, learning, project hub, ai tools, explore, profile subpages, placeholders).
- `RouteNames` centralizes all route path constants (`route_names.dart`).

---

## 6. Supabase Integration

- **Init** (`lib/main.dart`):
  ```dart
  await Supabase.initialize(
    url: Env.instance.supabaseUrl,
    anonKey: Env.instance.supabaseAnonKey,
  );
  ```
  - Import uses `hide LocalStorage` to avoid collision with `core/storage/local_storage.dart`.
  - `anonKey` is deprecated in supabase_flutter 2.16 → info at `main.dart:18` (use `publishableKey`).
- **Env values are placeholders** (e.g. `https://dev.supabase.co`, `DEV_SUPABASE_ANON_KEY`) in `config/env.dart`.
- **AuthService** (`features/auth/data/auth_service.dart`) — single entry point; UI must never call `Supabase.instance.client.auth` directly:
  - `signUp({email, password, fullName, username})` — also inserts a `profiles` row (`id = user.id`, `full_name`, `username`).
  - `signIn`, `signOut`, `resetPassword`, `currentUser`, `currentSession`, `authStateChanges`.

---

## 7. Auth Feature Deep Dive

**Register screen** (`features/auth/presentation/screens/register_screen.dart`):
- `ConsumerStatefulWidget`; controllers for name/email/password/confirm (all disposed).
- `Form` + `_formKey` + `Validators.required/email/password/confirmPassword`.
- `signUp()` → `ref.read(supabase_auth.authServiceProvider).signUp(...)` → SnackBar on success, `context.go(RouteNames.onboarding)`, `AuthException` handled.
- `AuthBottomBar(onPrimaryPressed: signUp, isLoading: _isLoading)`; `onFieldSubmitted: (_) => signUp()` on confirm field.
- Social buttons call the **legacy** `authProvider.notifier.signInWithGoogle()/signInWithGitHub()` (which hit the in-memory stub → immediately `error` state → SnackBar). **Not wired to Supabase.**
- `ref.listen(authProvider, ...)` shows SnackBar on legacy `error` state.

**Data layer:**
- `AuthRemoteDataSource` (abstract) — full CRUD + OAuth + OTP + avatar + deleteAccount.
- `AuthRemoteDataSourceImpl` — **Firebase stub**, all methods `UnimplementedError`.
- `AuthLocalDataSourceImpl` — in-memory map implementation (fake auth, not persisted). Provides the demo UI flow.
- `UserModel` (freezed 3 sealed, JSON-serializable) — fields incl. `uid`, `email`, `displayName`, `username`, `isEmailVerified`, `isProfileComplete`, `isOnboarded`, `isGithubConnected`, `hasResume`, timestamps.
- `user_model_mapper.dart` — `toEntity()`/`toModel()`.
- `UserEntity` + `AuthState` (freezed 3, `sealed`) — `AuthState` has initial/loading/authenticated/unauthenticated/onboardingRequired/error/passwordResetSent/otpSent/otpVerified/signedOut variants.

---

## 8. Networking (Dio)

`lib/core/network/`:
- `ApiClient` — Dio with `BaseOptions` from `Env.instance.baseUrl`, 3 interceptors, plus preconfigured external clients: `githubClient`, `hackerNewsClient`, `devToClient`, `semanticScholarClient`, `openAIClient` (Bearer from `Env.instance.openAIApiKey`).
- `AuthInterceptor` — **legacy custom JWT flow**: reads `auth_token` from `FlutterSecureStorage`, attaches `Authorization: Bearer`; on 401 tries `POST ${usersCollection}/refresh` with `refresh_token`, retries on success, else clears tokens. **Completely independent of Supabase.**
- `LoggingInterceptor` (enabled when `Env.instance.enableLogging`).
- `RetryInterceptor` (3 retries, timeouts + 5xx).
- `NetworkInfo` — connectivity_plus wrapper.

---

## 9. Storage

`lib/core/storage/`:
- `LocalStorage` (static Hive wrapper) — init opens 6 boxes (`user`, `settings`, `cache`, `bookmarks`, `drafts`, `searchHistory`); generic get/put/delete; cache with TTL; theme/locale/onboarding/user-id helpers; search history; clearAll/close.
- `HiveBoxes` — centralized box-name constants.
- `storage.dart` — barrel export.
- No Hive TypeAdapters registered yet (TODO in `init()`).

---

## 10. Localization

- `app_localizations.dart` — **hand-rolled** `LocalizationsDelegate` + static `Map<String, Map<String, String>>` for `en` (full), `hi`, `es` (partial).
- **No `.arb` files** and **no `flutter gen-l10n`** despite what README may imply.
- `app.dart` registers `AppLocalizations.delegate` + global delegates; `supportedLocales: en, hi, es`.

---

## 11. Theming

`lib/core/theme/`: `app_colors.dart`, `app_spacing.dart`, `app_theme.dart` (light/dark), `app_typography.dart`, `theme.dart` (barrel). `app.dart` applies light/dark themes with per-platform `PageTransitionsTheme` and `ThemeMode.system`. `builder` forces `TextScaler.noScaling`.

---

## 12. Error Handling

- `core/error/exceptions.dart` — typed exceptions (Server/Connection/Timeout/Cache/Auth/Parsing/Validation/File/Permission).
- `core/error/failures.dart` — freezed 3 `sealed class Failure` (10 variants) + `Failure.fromException` + `FailureExtension.displayMessage`. Migrated to Freezed 3 pattern syntax.

---

## 13. Testing & Static Analysis

- **1 stub test** (`test/widget_test.dart`) — no active assertions.
- `flutter_lints ^6.0.0` with strict defaults; analyzer reports ~324 **info**-level issues (no errors) at last check.
- **Debug APK builds successfully** for Android.

---

## 14. Architectural Issues Found

| # | Severity | Issue |
|---|----------|-------|
| 1 | **High** | **Two parallel auth systems.** Supabase (`AuthService`/new providers) coexists with the legacy in-memory `AuthLocalDataSourceImpl` + `AuthNotifier` + custom-JWT `AuthInterceptor`. The router, login screen, OTP screen, social buttons, and most auth UI still run on the **legacy/local** path — only the register screen uses Supabase. |
| 2 | **High** | `AuthRemoteDataSourceImpl` is a dead Firebase stub throwing `UnimplementedError`, yet `AuthLocalDataSourceImpl` (in-memory, non-persistent) is what the legacy UI actually uses — a fake-auth trap for demos. |
| 3 | **High** | **Router auth guard disabled** (`// Auth bypassed for now`). No real auth gate exists; app boots straight to Home. |
| 4 | **Medium** | Legacy `AuthInterceptor` implements its own JWT refresh against `${usersCollection}/refresh` — a second, custom auth stack that ignores Supabase sessions. |
| 5 | **Medium** | **Duplicate provider file names** (`providers/auth_provider.dart` vs `presentation/providers/auth_provider.dart`) require the alias `supabase_auth` — fragile, confusing. |
| 6 | **Medium** | **Firebase leftovers:** `google-services.json` + `com.google.gms.google-services` still applied in `android/` Gradle; `lib/firebase_options.dart` unreferenced. Harmless but misleading. |
| 7 | **Low** | `main.dart:18` `anonKey` deprecated → use `publishableKey`. |
| 8 | **Low** | Env config is placeholder strings; no real credentials for dev/staging/prod. |
| 9 | **Low** | `lib/shared/` empty; asset dirs empty but declared in pubspec; no Hive adapters registered. |
| 10 | **Low** | Hand-rolled l10n (no ARB/gen-l10n); partial hi/es. |
| 11 | **Low** | ~324 analyzer info-level issues; 1 stub test; not a git repo. |

---

## 15. Recommended Integration Plan (Supabase Auth)

Pending approval. Order matters:

1. **Keep** the current `register_screen.dart` + `AuthService` approach (Supabase via `authServiceProvider`).
2. **Route session changes** to the router: make `routerProvider` listen to `isAuthenticatedProvider` / `currentUserProvider` (or a small `AuthSessionNotifier`) instead of the legacy `authProvider`, then re-enable `redirect` to gate `/login` vs shell routes.
3. **Retire the legacy path:**
   - Re-point `login_screen.dart`, `forgot_password_screen.dart`, `otp_verification_screen.dart` at `AuthService`.
   - Wire Google/GitHub social buttons to Supabase OAuth (`signInWithOAuth`) — or hide until configured.
   - Replace the in-memory `AuthLocalDataSourceImpl` demo path with Supabase-backed calls or remove it.
   - Delete/neutralize `AuthRemoteDataSourceImpl` stub and consolidate the two provider files (keep `features/auth/providers/auth_provider.dart`, drop the alias).
4. **Align `AuthInterceptor`** to attach the Supabase access token (or remove the custom refresh flow).
5. **Cleanup:** remove Firebase Gradle plugin + `google-services.json` + `firebase_options.dart`; switch `anonKey` → `publishableKey`; fill real env values via `--dart-define`.
6. **Verify:** `flutter analyze`, add a widget/integration test for the signup flow, then `flutter build apk --debug`.

---

## 16. Files of Interest

| File | Role |
|------|------|
| `lib/main.dart` | Env + Supabase + Hive init; `hide LocalStorage`; `anonKey` deprecated |
| `lib/config/env.dart` | Placeholder URL/keys for dev/staging/prod |
| `lib/app.dart` | `MaterialApp.router`, theme, l10n delegates |
| `lib/core/router/app_router.dart` | `routerProvider`; redirect disabled; listens to legacy `authProvider` |
| `lib/core/router/route_names.dart` | All route path constants |
| `lib/features/auth/data/auth_service.dart` | Single Supabase auth entry point (+ profiles insert) |
| `lib/features/auth/providers/auth_provider.dart` | New Supabase Riverpod providers |
| `lib/features/auth/presentation/providers/auth_provider.dart` | Legacy `AuthNotifier`/`authProvider` (router + login/OTP/social depend on it) |
| `lib/features/auth/data/datasources/auth_local_datasource_impl.dart` | In-memory fake auth (legacy UI) |
| `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart` | Firebase stub — all `UnimplementedError` |
| `lib/features/auth/presentation/screens/register_screen.dart` | Supabase-wired signup UI |
| `lib/core/network/dio_interceptors.dart` | Legacy custom-JWT `AuthInterceptor` (independent of Supabase) |
| `lib/core/storage/local_storage.dart` | Hive wrapper; no adapters yet |
| `lib/core/l10n/app_localizations.dart` | Hand-rolled localization map |
| `pubspec.yaml` | No Firebase; freezed 3; empty asset dirs |

---

## 17. Status / Next Actions

- [x] Read-only audit complete.
- [ ] **Awaiting user approval** of this report before any code changes.
- [ ] Apply Section 15 integration plan in the approved order, verifying with `flutter analyze` and a debug build after each step.

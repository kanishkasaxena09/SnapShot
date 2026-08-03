# Snapshot

**AI-powered Tech Super App**

> Your all-in-one platform for AI tools, job discovery, skill analysis, GitHub exploration, and continuous learning.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Dart](https://img.shields.io/badge/Dart-3.12-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)

---

## Screenshots

<p align="center">
  <img src="screenshots/home.png" width="24%" />
  <img src="screenshots/ai_assistant.png" width="24%" />
  <img src="screenshots/skill_analyzer.png" width="24%" />
  <img src="screenshots/jobs.png" width="24%" />
</p>

---

## Features

- **AI Assistant** -- Multi-mode chat (General, Code Review, Architecture, Debug) with streaming responses, markdown rendering, and code highlighting.
- **Skill Analyzer** -- Radar charts, ATS analysis, missing skills detection, course recommendations, salary estimates, and personalized learning plans.
- **Job Portal** -- Job search with AI match scores, salary insights, company profiles, application tracking, and recruiter contacts.
- **GitHub Explorer** -- Trending repos & developers, repository details, developer profiles, and search.
- **Learning Hub** -- Roadmaps, lessons, quizzes, videos, notes, cheat sheets, daily challenges, achievements, certificates, and streak tracking.
- **AI Tools Directory** -- Searchable catalog with category/pricing filters, side-by-side comparison, reviews, and bookmarks.
- **Project Hub** -- Browse, filter, and follow step-by-step project guides with AI-powered recommendations.
- **Home Dashboard** -- Daily Tech Pulse, news, trending tech, research papers, hackathons, and personalized recommendations.
- **Profile & Settings** -- Stats, bookmarks, achievements, theme settings, and account management.
- **Onboarding** -- Multi-step profile setup with experience level, career goals, interests, GitHub connection, and resume upload.
- **Localization** -- English, Hindi, and Spanish support out of the box.

---

## Architecture

Snapshot follows a **feature-first** structure with **clean architecture** layers inside each feature.

```
lib/
├── main.dart                        # Entry point
├── app.dart                         # MaterialApp / App widget
├── config/
│   └── env.dart                     # Environment configuration
├── core/
│   ├── constants/                   # App-wide constants
│   ├── error/                       # Error widgets and handlers
│   ├── extensions/                  # Dart/Flutter extensions
│   ├── l10n/                        # Localization (ARB + generated)
│   ├── network/                     # Dio client, interceptors
│   ├── providers/                   # Core Riverpod providers
│   ├── router/                      # GoRouter configuration & route names
│   ├── storage/                     # Hive & Secure Storage setup
│   ├── theme/                       # Material/Cupertino theme
│   ├── utils/                       # Shared utilities (ScoreUtils, etc.)
│   └── widgets/                     # Shared UI widgets (buttons, badges, cards, shimmer, etc.)
├── features/
│   ├── ai_assistant/
│   │   ├── data/                    # Data sources, models, repositories
│   │   ├── domain/                  # Entities, use cases
│   │   └── presentation/           # Screens, widgets, providers
│   ├── ai_tools/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── explore/
│   │   ├── data/
│   │   └── presentation/
│   ├── github/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── home/
│   │   ├── data/
│   │   └── presentation/
│   ├── jobs/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── learning/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── more/
│   │   └── presentation/
│   ├── profile/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── project_hub/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── skill_analyzer/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── shared/
    ├── models/                      # Shared data models
    ├── providers/                   # Cross-feature providers
    ├── services/                    # Shared services
    └── widgets/                     # Cross-feature widgets (legacy)
```

### Clean Architecture Layers

| Layer | Responsibility |
|-------|---------------|
| **data/** | Data sources (remote/local), DTOs, repository implementations |
| **domain/** | Business entities, use cases, repository interfaces |
| **presentation/** | UI (screens, widgets), Riverpod providers, state classes |

---

## Getting Started

### Prerequisites

- **Flutter SDK** >= 3.12.2
- **Dart SDK** >= 3.12.2
- **Android Studio** / **VS Code** with Flutter plugin
- An Android emulator, iOS simulator, or physical device

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/snapshot.git
cd snapshot

# Install dependencies
flutter pub get

# Run code generation (freezed, riverpod, json_serializable)
dart run build_runner build --delete-conflicting-outputs
```

### Running

```bash
# Run in debug mode
flutter run

# Run on a specific device
flutter run -d <device-id>

# Build release APK
flutter build apk --release

# Build release iOS
flutter build ios --release
```

---

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Flutter 3.x |
| Language | Dart 3.12 |
| State Management | Riverpod 2.6 |
| Routing | GoRouter 14.8 |
| Networking | Dio 5.7 |
| Serialization | Freezed + json_serializable |
| Local Storage | Hive + Flutter Secure Storage |
| Charts | fl_chart |
| UI Animations | flutter_animate, shimmer, flutter_staggered_animations |
| Images | cached_network_image, flutter_svg, Lottie |
| Responsiveness | responsive_framework |
| Fonts | Google Fonts |
| Localization | Flutter intl (ARB files) |
| Testing | flutter_test, mocktail |
| Linting | flutter_lints |

---

## State Management

The project uses **Riverpod** for dependency injection and state management.

- **Providers** are defined close to the feature they serve.
- **Generated providers** (`riverpod_annotation` + `riverpod_generator`) are preferred for type-safe, compile-time checked dependencies.
- **Manual providers** (`Provider`, `StateProvider`, `StateNotifierProvider`, `AsyncNotifierProvider`) are used where generation is unnecessary.
- Cross-feature shared state lives in `shared/providers/` or `core/providers/`.
- Bookmark/save/star toggles use the generic `IdSetNotifier` to avoid duplicating toggle logic.

---

## Routing

Routing is handled by **GoRouter** with a centralized configuration in `core/router/`.

- `router.dart` -- Main `GoRouter` instance with all route definitions.
- `app_router.dart` -- Router provider exposed to the widget tree.
- `route_names.dart` -- String constants for all named routes.

Navigation uses Cupertino-style page transitions for a platform-native feel.

---

## Localization

Snapshot supports three languages via Flutter's built-in localization:

| Language | Code |
|----------|------|
| English | `en` |
| Hindi | `hi` |
| Spanish | `es` |

ARB files are located in `lib/core/l10n/`. Generated delegate classes are produced by `flutter gen-l10n`.

---

## Testing

Testing strategy and guidelines are documented in [TESTING_STRATEGY.md](TESTING_STRATEGY.md).

Run all tests:

```bash
flutter test
```

Run with coverage:

```bash
flutter test --coverage
```

---

## Contributing

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`.
3. Commit changes: `git commit -m "feat: add my feature"`.
4. Push to the branch: `git push origin feature/my-feature`.
5. Open a Pull Request.

Please follow existing code conventions and ensure all tests pass before submitting.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

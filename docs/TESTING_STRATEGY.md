# Snapshot - Testing Strategy

> Comprehensive testing plan for the Snapshot AI-powered Tech Super App.

---

## Table of Contents

1. [Testing Philosophy](#1-testing-philosophy)
2. [Unit Testing](#2-unit-testing)
3. [Widget Testing](#3-widget-testing)
4. [Integration Testing](#4-integration-testing)
5. [Test File Structure](#5-test-file-structure)
6. [Mocking Strategy](#6-mocking-strategy)
7. [Coverage Goals](#7-coverage-goals)
8. [CI/CD Integration](#8-cicd-integration)

---

## 1. Testing Philosophy

### Test Pyramid

Snapshot follows the **test pyramid** approach:

```
        /  Integration  \        ~10% of tests
       /   E2E Flows     \       Key user journeys
      /--------------------\
     /    Widget Tests      \    ~30% of tests
    /  Component rendering   \   UI correctness & interaction
   /   & user interaction     \
  /----------------------------\
 /       Unit Tests              \  ~60% of tests
/  Providers, Utils, Entities,    \ Core business logic
/   Datasource, Repository logic  \
/------------------------------------\
```

**Principles:**
- **Test behavior, not implementation** -- Tests should survive refactoring.
- **Fast feedback** -- Unit tests run in < 1s. Widget tests in < 5s each.
- **Isolation** -- Each test is independent. No shared mutable state between tests.
- **Deterministic** -- No `DateTime.now()`, no random values, no network calls.
- **Readable** -- Test names describe the scenario, not the method.

---

## 2. Unit Testing

Unit tests validate individual classes and functions in isolation.

### 2.1 Providers

#### IdSetNotifier

`lib/core/providers/id_set_notifier.dart` -- A generic `StateNotifier<List<String>>` for toggle-based selections (bookmarks, filters, skill imports).

```dart
// test/core/providers/id_set_notifier_test.dart

void main() {
  group('IdSetNotifier', () {
    test('starts with initial list', () {
      final notifier = IdSetNotifier(['a', 'b']);
      expect(notifier.state, ['a', 'b']);
    });

    test('toggles id into the set', () {
      final notifier = IdSetNotifier();
      notifier.toggle('x');
      expect(notifier.state, ['x']);
      expect(notifier.contains('x'), isTrue);
    });

    test('toggles id out of the set', () {
      final notifier = IdSetNotifier(['x']);
      notifier.toggle('x');
      expect(notifier.state, isEmpty);
      expect(notifier.contains('x'), isFalse);
    });

    test('respects maxSize limit', () {
      final notifier = IdSetNotifier([], maxSize: 2);
      notifier.toggle('a');
      notifier.toggle('b');
      notifier.toggle('c'); // should not be added
      expect(notifier.state.length, 2);
      expect(notifier.contains('c'), isFalse);
    });

    test('clear empties the list', () {
      final notifier = IdSetNotifier(['a', 'b', 'c']);
      notifier.clear();
      expect(notifier.state, isEmpty);
    });
  });
}
```

#### BookmarkListNotifier (feature-specific)

Test that bookmark toggling propagates correctly through providers.

#### Filter logic (Jobs)

Test that `JobFilter` combinations produce the correct subset when passed to `JobLocalDataSource.searchJobs`.

### 2.2 Utils

#### ScoreUtils

`lib/core/utils/score_utils.dart`

```dart
// test/core/utils/score_utils_test.dart

void main() {
  group('ScoreUtils.colorForScore', () {
    test('returns success color for score >= 80', () {
      expect(ScoreUtils.colorForScore(80), AppColors.successLight);
      expect(ScoreUtils.colorForScore(100), AppColors.successLight);
    });

    test('returns orange color for score 60-79', () {
      expect(ScoreUtils.colorForScore(60), AppColors.accentOrange);
      expect(ScoreUtils.colorForScore(79), AppColors.accentOrange);
    });

    test('returns error color for score < 60', () {
      expect(ScoreUtils.colorForScore(0), AppColors.errorLight);
      expect(ScoreUtils.colorForScore(59), AppColors.errorLight);
    });
  });

  group('ScoreUtils.labelForScore', () {
    test('returns correct labels for each threshold', () {
      expect(ScoreUtils.labelForScore(95), 'Exceptional');
      expect(ScoreUtils.labelForScore(85), 'Strong');
      expect(ScoreUtils.labelForScore(75), 'Good');
      expect(ScoreUtils.labelForScore(65), 'Developing');
      expect(ScoreUtils.labelForScore(40), 'Needs Improvement');
    });
  });
}
```

### 2.3 Entities and Models

Test Freezed-generated methods on domain entities:

- **Equality** -- Two entities with the same fields should be `==`.
- **`copyWith`** -- Verify selective field updates.
- **`toJson` / `fromJson`** -- Round-trip serialization for models.
- **Default values** -- Verify defaults for optional fields.

```dart
// Example: test/features/auth/data/models/user_model_test.dart
test('UserModel copyWith updates only specified fields', () {
  final user = UserModel(uid: '1', email: 'a@b.com', ...);
  final updated = user.copyWith(displayName: 'New Name');
  expect(updated.displayName, 'New Name');
  expect(updated.email, 'a@b.com'); // unchanged
});
```

### 2.4 Datasource Logic

Test non-trivial logic within datasources:

- `AIAssistantLocalDataSource.generateAIResponse` -- Verify routing to the correct response template based on keywords and modes.
- `ExploreLocalDataSource.searchArticles` -- Verify search matches across title, summary, and tags.
- `JobLocalDataSource.searchJobs` -- Verify multi-criteria filtering and sorting produce correct results.
- `ProjectHubLocalDataSource.getRecommendations` -- Verify match scoring logic.
- `SkillAnalyzerLocalDataSource.analyzeFromSources` -- Verify that different source combinations produce different skill sets.

---

## 3. Widget Testing

Widget tests render widgets in a simulated Flutter environment and verify UI output and interactions.

### 3.1 Core Widgets

#### SectionCard

```dart
// test/core/widgets/section_card_test.dart

testWidgets('renders title when provided', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: SectionCard(title: 'Test Title', child: Text('Content')),
  ));
  expect(find.text('Test Title'), findsOneWidget);
  expect(find.text('Content'), findsOneWidget);
});

testWidgets('renders without title', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: SectionCard(child: Text('Content')),
  ));
  expect(find.text('Content'), findsOneWidget);
  // No title row should be rendered
});

testWidgets('onTap callback fires', (tester) async {
  var tapped = false;
  await tester.pumpWidget(MaterialApp(
    home: SectionCard(onTap: () => tapped = true, child: Text('Tap me')),
  ));
  await tester.tap(find.byType(SectionCard));
  expect(tapped, isTrue);
});
```

#### ColoredBadge

```dart
testWidgets('displays label text', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ColoredBadge(label: 'Flutter', color: Colors.blue),
  ));
  expect(find.text('Flutter'), findsOneWidget);
});

testWidgets('displays icon when provided', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ColoredBadge(label: 'Go', color: Colors.teal, icon: Icons.code),
  ));
  expect(find.byIcon(Icons.code), findsOneWidget);
});
```

#### ProgressLine

```dart
testWidgets('renders LinearProgressIndicator', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ProgressLine(value: 0.65),
  ));
  final indicator = tester.widget<LinearProgressIndicator>(
    find.byType(LinearProgressIndicator),
  );
  expect(indicator.value, 0.65);
});
```

#### BookmarkButton

```dart
testWidgets('toggles icon based on isBookmarked', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: BookmarkButton(isBookmarked: false, onPressed: () {}),
  ));
  expect(find.byIcon(Icons.bookmark_outline_rounded), findsOneWidget);

  await tester.pumpWidget(MaterialApp(
    home: BookmarkButton(isBookmarked: true, onPressed: () {}),
  ));
  expect(find.byIcon(Icons.bookmark_rounded), findsOneWidget);
});

testWidgets('calls onPressed when tapped', (tester) async {
  var pressed = false;
  await tester.pumpWidget(MaterialApp(
    home: BookmarkButton(isBookmarked: false, onPressed: () => pressed = true),
  ));
  await tester.tap(find.byType(BookmarkButton));
  expect(pressed, isTrue);
});
```

#### EmptyState

```dart
testWidgets('displays icon, title, and message', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: EmptyState(
      icon: Icons.inbox,
      title: 'No Items',
      message: 'Nothing here yet.',
    ),
  ));
  expect(find.byIcon(Icons.inbox), findsOneWidget);
  expect(find.text('No Items'), findsOneWidget);
  expect(find.text('Nothing here yet.'), findsOneWidget);
});

testWidgets('renders action button when provided', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: EmptyState(
      icon: Icons.inbox,
      title: 'Empty',
      message: 'No data',
      actionLabel: 'Retry',
      onAction: () {},
    ),
  ));
  expect(find.text('Retry'), findsOneWidget);
});
```

### 3.2 Feature Cards and Tiles

Test feature-specific card widgets that appear in lists:

- Job cards render company name, salary, and match score
- AI tool cards display rating, pricing badge, and category icon
- Project cards show difficulty badge, technology tags, and completion rate
- Article cards render title, source, and read time

**Pattern:** Each test should verify:
1. Correct data is displayed
2. Interaction (tap) triggers navigation or callback
3. Conditional elements (badges, icons) appear based on entity state

---

## 4. Integration Testing

Integration tests verify complete user flows across multiple screens and providers.

### 4.1 Onboarding -> Home

```dart
// integration_test/onboarding_to_home_test.dart

testWidgets('completes onboarding and reaches home', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Verify onboarding screens appear
  expect(find.text('Welcome to Snapshot'), findsOneWidget);

  // Tap through onboarding pages
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Get Started'));
  await tester.pumpAndSettle();

  // Verify home screen is displayed
  expect(find.text('Tech Pulse'), findsOneWidget);
});
```

### 4.2 Login -> Profile

```dart
testWidgets('signs in and navigates to profile', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Enter email and password
  await tester.enterText(find.byKey(Key('email_field')), 'test@local.dev');
  await tester.enterText(find.byKey(Key('password_field')), 'password123');
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();

  // Navigate to profile
  await tester.tap(find.byIcon(Icons.person));
  await tester.pumpAndSettle();

  expect(find.text('Alex Morgan'), findsOneWidget);
});
```

### 4.3 Job Search -> Apply

```dart
testWidgets('searches jobs and applies', (tester) async {
  // Navigate to jobs
  // Enter search query
  // Verify filtered results
  // Tap on a job card
  // Tap Apply button
  // Verify application status changes
});
```

### 4.4 AI Chat Flow

```dart
testWidgets('creates conversation and sends message', (tester) async {
  // Navigate to AI Assistant
  // Tap "New Chat"
  // Verify empty conversation
  // Type a message
  // Tap send
  // Verify user message appears
  // Verify AI response appears
  // Verify conversation appears in sidebar
});
```

### 4.5 Bookmark/Unbookmark Flow

```dart
testWidgets('bookmarks and unbookmarks an article', (tester) async {
  // Navigate to Explore
  // Tap bookmark icon on first article
  // Verify icon changes to filled
  // Navigate to Bookmarks
  // Verify article appears
  // Go back and unbookmark
  // Verify article disappears from bookmarks
});
```

---

## 5. Test File Structure

```
test/
  core/
    providers/
      id_set_notifier_test.dart
    utils/
      score_utils_test.dart
      validators_test.dart
      formatters_test.dart
    widgets/
      section_card_test.dart
      colored_badge_test.dart
      progress_line_test.dart
      bookmark_button_test.dart
      empty_state_test.dart
  features/
    auth/
      data/
        datasources/
          auth_local_datasource_impl_test.dart
          user_local_datasource_test.dart
      providers/
        auth_provider_test.dart
    ai_assistant/
      data/
        datasources/
          ai_assistant_local_datasource_test.dart
      providers/
        ai_assistant_provider_test.dart
    explore/
      data/
        datasources/
          explore_local_datasource_test.dart
      providers/
        explore_provider_test.dart
    skill_analyzer/
      data/
        datasources/
          skill_analyzer_local_datasource_test.dart
    jobs/
      data/
        datasources/
          job_local_datasource_test.dart
      providers/
        job_provider_test.dart
    github/
      data/
        datasources/
          github_local_datasource_test.dart
    ai_tools/
      data/
        datasources/
          ai_tools_local_datasource_test.dart
    learning/
      data/
        datasources/
          learning_local_datasource_test.dart
    project_hub/
      data/
        datasources/
          project_hub_local_datasource_test.dart
    profile/
      data/
        datasources/
          profile_local_datasource_test.dart
  integration_test/
    onboarding_flow_test.dart
    auth_flow_test.dart
    job_search_flow_test.dart
    ai_chat_flow_test.dart
    bookmark_flow_test.dart
```

---

## 6. Mocking Strategy

### Dependency: mocktail

Already declared in `pubspec.yaml`:

```yaml
dev_dependencies:
  mocktail: ^1.0.4
```

### Mocking Datasources

Since repositories wrap datasources, mock datasources in repository tests:

```dart
import 'package:mocktail/mocktail.dart';
import 'package:snapshot/features/explore/data/datasources/explore_local_datasource.dart';

class MockExploreLocalDataSource extends Mock
    implements ExploreLocalDataSource {}

void main() {
  late MockExploreLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockExploreLocalDataSource();
  });

  test('getPopularArticles delegates to datasource', () {
    final articles = [/* test data */];
    when(() => mockDataSource.getPopularArticles()).thenReturn(articles);

    // Call repository method and verify delegation
    verify(() => mockDataSource.getPopularArticles()).called(1);
  });
}
```

### Mocking Pattern by Layer

| Layer | What to Mock | Why |
|---|---|---|
| **Provider tests** | The `Provider` override | Test notifier logic in isolation |
| **Repository tests** | Datasource classes | Verify delegation and data transformation |
| **Widget tests** | Providers via `ProviderContainer` override | Provide controlled state to widgets |
| **Integration tests** | Nothing | Real datasources provide mock data |

### Register Fallback Values

```dart
setUpAll(() {
  registerFallbackValue(const ExploreCategory.ai);
  registerFallbackValue(const JobFilter());
});
```

---

## 7. Coverage Goals

### Target Percentages

| Area | Target | Rationale |
|---|---|---|
| **Core utils** | 100% | Pure functions, easy to test, high impact |
| **Providers** | 90%+ | State logic is the backbone of the app |
| **Datasource logic** | 85%+ | Filter/search/sort logic must be reliable |
| **Core widgets** | 80%+ | Shared across all features |
| **Feature widgets** | 60%+ | Prioritize screens with user input |
| **Integration flows** | Key 5 journeys | Cover critical happy paths |
| **Overall** | 70%+ | Balanced with development velocity |

### Coverage Commands

```bash
# Run tests with coverage
flutter test --coverage

# View coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Enforce minimum coverage in CI
flutter test --coverage --min-coverage=70
```

---

## 8. CI/CD Integration

### GitHub Actions Workflow

```yaml
# .github/workflows/test.yml

name: Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Verify formatting
        run: dart format --set-exit-if-changed .

      - name: Analyze code
        run: flutter analyze --no-fatal-infos

      - name: Run tests
        run: flutter test --coverage

      - name: Check coverage threshold
        run: |
          COVERAGE=$(lcov --summary coverage/lcov.info 2>&1 | grep 'lines' | grep -oP '\d+\.\d+')
          if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            echo "Coverage $COVERAGE% is below 70% threshold"
            exit 1
          fi

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v4
        with:
          files: coverage/lcov.info
```

### Pre-commit Hook (optional)

```bash
#!/bin/bash
# .githooks/pre-commit

echo "Running tests..."
flutter test
if [ $? -ne 0 ]; then
  echo "Tests failed. Commit aborted."
  exit 1
fi

echo "Checking formatting..."
dart format --set-exit-if-changed .
if [ $? -ne 0 ]; then
  echo "Formatting issues. Run: dart format ."
  exit 1
fi
```

### Test Execution Order

For fast CI feedback, run tests in this order:

1. **Unit tests** (~5s) -- Fastest, catches logic bugs
2. **Widget tests** (~30s) -- Catches UI regressions
3. **Static analysis** (~10s) -- `dart analyze`
4. **Formatting check** (~3s) -- `dart format`
5. **Integration tests** (~2min) -- Full user flows (run on merge to main only)

---

## Quick Reference: Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/core/utils/score_utils_test.dart

# Run tests matching a name pattern
flutter test --name "ScoreUtils"

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

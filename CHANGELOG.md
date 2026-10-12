# Changelog

All notable changes to the Snapshot project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-07-22

### Added

#### Onboarding & Authentication
- Multi-step onboarding flow with profile setup (experience level, career goals,interests, technology selection, GitHub connection, resume upload)
- Email/password authentication with OTP verification
- Google sign-in integration
- Password reset flow

#### Home Dashboard
- Daily Tech Pulse section for personalized tech updates
- Learning Hub section with quick access to courses and roadmaps
- Breaking News feed
- Trending Tech topics
- Trending GitHub repositories and developers
- Trending AI Tools
- Research Papers section
- Recommended Jobs based on profile
- Hackathons listing
- Featured Projects showcase
- Continue Learning progress cards

#### AI Assistant
- Multi-turn conversation with history persistence
- Streaming mock responses for real-time feel
- Markdown rendering with code syntax highlighting
- Chat settings and conversation management
- Multiple specialized modes: General, Code Review, Architecture, Debug

#### Skill Analyzer
- Radar/circular chart visualizations for skill assessment
- ATS (Applicant Tracking System) analysis
- Detailed skill breakdown with proficiency levels
- Missing skills identification and recommendations
- Personalized course recommendations
- Career path suggestions with salary estimates
- Structured learning plans

#### Job Portal
- Job search with keyword and location filters
- AI-powered match scores for job listings
- Detailed job views with salary insights
- Company profiles and recruiter contacts
- Application tracking system
- Job alerts and notifications

#### GitHub Explorer
- Trending repositories with language and star filters
- Trending developers leaderboard
- Repository detail views with contributor stats
- Developer profile pages
- GitHub search across repos and users

#### Learning Hub
- Technology roadmaps with milestone tracking
- Interactive lessons with rich content
- Quizzes and knowledge checks
- Video tutorials integration
- Notes and personal documentation
- Quick-reference cheat sheets
- Daily coding challenges
- Achievement and badge system
- Certificate generation on course completion
- Streak tracking for consistent learning

#### AI Tools Directory
- Comprehensive AI tools catalog
- Search across all tools
- Category, pricing model, and sort filters
- Side-by-side tool comparison
- Detailed tool pages with user reviews
- Bookmarked tools collection

#### Project Hub
- Project browsing with search
- Difficulty, category, and technology filters
- Detailed project views with step-by-step guides
- Personalized project recommendations
- Project cards with progress indicators

#### Profile & Settings
- User stats dashboard (learning, GitHub, skills)
- Resume score analysis
- Bookmarks and history management
- Achievement showcase
- Theme settings (light/dark)
- Account management

#### More Screen
- Organized quick actions grouped by domain: AI & Productivity, Learning & Skills, Development, Career

#### General
- Full localization support: English, Hindi, Spanish
- Cupertino-style page transitions
- Hero animations across cards and detail screens
- Pull-to-refresh on AI Tools, Project Hub, and Jobs screens
- Shimmer loading skeletons for all major lists
- Accessibility semantics on key interactive widgets
- RepaintBoundary optimization on all home dashboard sections

### Changed (Refactoring)
- Extracted generic `IdSetNotifier` for bookmark/save/star toggle state across features
- Extracted shared widgets into `core/widgets/`: `SectionCard`, `ColoredBadge`, `ProgressLine`, `BookmarkButton`, `DetailNotFoundScreen`, `AppEmptyState`
- Extracted `ScoreUtils` utility for score-to-color and score-to-label mapping
- Renamed `achievementsProvider` to `profileAchievementsProvider` and `learningAchievementsProvider` to avoid name collisions
- Renamed `authRemoteDataSourceProvider` to `authDataSourceProvider` (was misleadingly named)
- Standardized explore provider names with feature prefix (`exploreSearchQueryProvider`, etc.)
- Moved `ai_assistant/widgets/` and `skill_analyzer/widgets/` into `presentation/widgets/` for consistent feature architecture
- Removed duplicate `EmptyState` class from `error_widgets.dart`
- Replaced inline score color logic with `ScoreUtils` across 5 files
- Replaced inline detail-not-found scaffolds with `DetailNotFoundScreen` in 3 screens
- Fixed `ref.watch` to `ref.read` bug in `authProvider` for singleton data source
- Fixed `ProviderScope.containerOf` anti-pattern in `applications_screen.dart`

### Removed
- Unused providers: `userRemoteDataSourceProvider`, `sortByProvider`, `onboardingProgressProvider`, `newProjectsProvider`
- Dead route name: `githubExplorer`
- Deprecated `shared/providers/auth_provider.dart` re-export file
- Duplicate `EmptyState` / `ErrorView` classes from `error_widgets.dart`

### Fixed
- `TabAlignment.start` error in app theme (removed non-scrollable `TabBar` incompatibility)
- RenderFlex overflow errors (14px, 26px) by adding `Flexible`/`Expanded` to 8 `Row` widgets
- BookmarksScreen remove button now functional (converted to `StateNotifierProvider`)
- Floating AI button now always opens a new chat instead of showing conversation history
- More screen fixed: AI Chat route added, Development section routes corrected, ATS Analyzer replaced with Cheat Sheets

# Snapshot - API Documentation

> Comprehensive documentation of the Snapshot data layer, covering all feature datasources, entities, and providers.

---

## Table of Contents

1. [Data Architecture Overview](#1-data-architecture-overview)
2. [Auth](#2-auth)
3. [AI Assistant](#3-ai-assistant)
4. [Explore](#4-explore)
5. [Skill Analyzer](#5-skill-analyzer)
6. [Jobs](#6-jobs)
7. [GitHub](#7-github)
8. [AI Tools](#8-ai-tools)
9. [Learning](#9-learning)
10. [Project Hub](#10-project-hub)
11. [Profile](#11-profile)
12. [Home](#12-home)

---

## 1. Data Architecture Overview

### Local Datasource Pattern

Snapshot uses a **local-first datasource architecture**. Every feature module contains one or more datasource classes that provide mock data entirely in-memory. There is no real backend; all data is generated and stored within Dart objects at runtime.

```
lib/features/<feature>/
  data/
    datasources/   <-- DataSource classes (data access layer)
    models/        <-- JSON-serializable models
  domain/
    entities/      <-- Immutable domain entities (often Freezed)
    repositories/  <-- Repository abstractions
  presentation/    <-- Providers (Riverpod), screens, widgets
```

**Key design principles:**

- **No persistence across restarts** -- All data lives in `Map` or `List` fields. Restarting the app resets everything.
- **Interface segregation** -- Auth defines an `AuthRemoteDataSource` abstract class. `AuthLocalDataSourceImpl` implements it so the app can swap in a real backend later with zero provider changes.
- **Repository as the single source of truth** -- Repositories (not datasources) are injected into providers. Datasources are repository-internal implementation details.
- **Riverpod for DI** -- All repositories are exposed via `Provider` or `NotifierProvider`. Datasources are created inside repository constructors.

### Conventions

| Convention | Description |
|---|---|
| `*LocalDataSource` | In-memory mock data store |
| `*RemoteDataSource` | Abstract or stub for Firebase/HTTP (currently throws `UnimplementedError`) |
| `*Entities` | Freezed/immutable domain objects |
| `*Providers` | Riverpod providers that expose repository methods to the UI |

---

## 2. Auth

**Files:**
- `auth/data/datasources/auth_remote_datasource.dart` -- Abstract contract
- `auth/data/datasources/auth_local_datasource_impl.dart` -- Local implementation
- `auth/data/datasources/auth_remote_datasource_impl.dart` -- Firebase stub
- `auth/data/datasources/user_local_datasource.dart` -- User CRUD
- `auth/data/datasources/user_remote_datasource.dart` -- Firebase stub

### AuthRemoteDataSource (abstract)

The abstract contract that `AuthLocalDataSourceImpl` implements.

| Method | Return Type | Description |
|---|---|---|
| `signInWithEmail({email, password})` | `Future<UserModel>` | Signs in or creates a user by email |
| `signUpWithEmail({email, password, displayName})` | `Future<UserModel>` | Registers a new user |
| `signInWithGoogle()` | `Future<UserModel>` | Simulates Google sign-in |
| `signInWithGitHub()` | `Future<UserModel>` | Simulates GitHub sign-in |
| `signOut()` | `Future<void>` | Clears current user session |
| `sendPasswordResetEmail({email})` | `Future<void>` | No-op locally |
| `verifyOtp({email, otp})` | `Future<void>` | No-op locally |
| `sendOtp({email})` | `Future<void>` | No-op locally |
| `getCurrentUser()` | `Future<UserModel?>` | Returns current user or null |
| `updateProfile(UserModel user)` | `Future<UserModel>` | Updates user profile |
| `uploadAvatar({filePath})` | `Future<String>` | Returns empty string locally |
| `deleteAccount()` | `Future<void>` | Removes user from in-memory store |

### AuthLocalDataSourceImpl

Implements `AuthRemoteDataSource`. Maintains an internal `Map<String, UserModel>` and a `_currentUid` pointer. Auto-generates UIDs from timestamps + random suffix.

### UserLocalDataSource

| Method | Return Type | Description |
|---|---|---|
| `getUser(String uid)` | `Future<UserModel?>` | Look up user by UID |
| `getCurrentUser(String? uid)` | `Future<UserModel?>` | Null-safe variant of `getUser` |
| `updateUser(UserModel user)` | `Future<UserModel>` | Replace user in store |
| `updateField(String uid, Map<String, dynamic> data)` | `Future<void>` | Partial field update via JSON merge |
| `isUsernameAvailable(String username)` | `Future<bool>` | True if no user has that username |
| `isEmailTaken(String email)` | `Future<bool>` | True if email is already registered |
| `deleteUser(String uid)` | `Future<void>` | Remove user from store |

### Entity: `UserModel`

| Field | Type | Description |
|---|---|---|
| `uid` | `String` | Unique identifier |
| `email` | `String` | User email |
| `displayName` | `String` | Full name |
| `username` | `String?` | Optional handle |
| `avatarUrl` | `String?` | Profile image URL |
| `createdAt` | `DateTime` | Account creation timestamp |
| `updatedAt` | `DateTime` | Last profile update |
| `lastLoginAt` | `DateTime` | Last sign-in time |
| `isProfileComplete` | `bool` | Whether onboarding is done |
| `isOnboarded` | `bool` | Whether intro screens are dismissed |

---

## 3. AI Assistant

**File:** `ai_assistant/data/datasources/ai_assistant_local_datasource.dart`

### AIAssistantLocalDataSource

Pre-populated with 2 conversations (Flutter State Management, Career Path in AI/ML). Maintains an internal `_conversations` list with an auto-incrementing counter.

| Method | Return Type | Description |
|---|---|---|
| `getConversations()` | `List<Conversation>` | All conversations (unmodifiable) |
| `getConversation(String id)` | `Conversation?` | Single conversation by ID |
| `createConversation({title, mode})` | `Conversation` | Creates and inserts a new conversation at the top |
| `deleteConversation(String id)` | `void` | Removes conversation by ID |
| `updateConversation(Conversation)` | `void` | Replaces conversation in-place |
| `generateAIResponse(String userMessage, AIAssistantMode mode)` | `String` | Returns a mock AI response based on message content and mode |

### `generateAIResponse` routing

The method inspects the user message and mode to pick a response:

| Keyword / Mode | Response |
|---|---|
| `resume` / `AIAssistantMode.resumeAnalysis` | Structured resume analysis with score, strengths, and suggestions |
| `github` / `repo` / `AIAssistantMode.githubAnalysis` | GitHub profile analysis with stats table |
| `career` / `job` / `AIAssistantMode.careerGuidance` | Market trends, salary insights, action plan |
| `learn` / `roadmap` / `study` / `AIAssistantMode.learningRoadmap` | 12-week personalized learning plan |
| `code` / `flutter` / `dart` | Code example (SmartCounter widget) |
| Default | General AI response with tips |

### Entities

| Entity | Key Fields |
|---|---|
| `Conversation` | `id`, `title`, `messages`, `createdAt`, `updatedAt`, `mode` |
| `ChatMessage` | `id`, `role` (user/assistant), `content`, `timestamp` |
| `AIAssistantMode` | enum: `general`, `resumeAnalysis`, `githubAnalysis`, `careerGuidance`, `learningRoadmap` |

---

## 4. Explore

**File:** `explore/data/datasources/explore_local_datasource.dart`

### ExploreLocalDataSource

Pre-loaded with 24 articles across 8 categories: AI, Programming, Cloud, Cybersecurity, DevOps, Startups, Research, GitHub, and Events.

| Method | Return Type | Description |
|---|---|---|
| `getAllArticles()` | `List<ExploreArticle>` | All articles (unmodifiable) |
| `getArticlesByCategory(ExploreCategory)` | `List<ExploreArticle>` | Filter by category |
| `searchArticles(String query)` | `List<ExploreArticle>` | Search by title, summary, or tags |
| `getBookmarkedArticles()` | `List<ExploreArticle>` | Only bookmarked articles |
| `toggleBookmark(String articleId)` | `void` | Toggle bookmark state |
| `isBookmarked(String articleId)` | `bool` | Check if article is bookmarked |
| `updateReadingProgress(String articleId, double progress)` | `void` | Set reading progress (0.0 -- 1.0) |
| `getReadingProgress(String articleId)` | `double` | Get progress, defaults to 0.0 |
| `getPopularArticles()` | `List<ExploreArticle>` | Articles tagged `popular` |
| `getTrendingArticles()` | `List<ExploreArticle>` | Articles tagged `trending` |

### Entity: `ExploreArticle`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `title` | `String` | Article headline |
| `summary` | `String` | Short description |
| `content` | `String` | Full article text |
| `author` | `String` | Author name |
| `source` | `String` | Publication source |
| `publishedAt` | `String` | Relative time string |
| `readTime` | `int` | Estimated read time in minutes |
| `category` | `ExploreCategory` | Category enum |
| `tags` | `List<String>` | Tag list for filtering |

### `ExploreCategory` enum values

`ai`, `programming`, `cloud`, `cybersecurity`, `devops`, `startups`, `research`, `github`, `events`

---

## 5. Skill Analyzer

**File:** `skill_analyzer/data/datasources/skill_analyzer_local_datasource.dart`

### SkillAnalyzerLocalDataSource

| Method | Return Type | Description |
|---|---|---|
| `analyzeFromSources(List<ImportSource> sources)` | `SkillAnalysis` | Builds a complete skill analysis from selected import sources (GitHub, LinkedIn, Resume) |

All other methods are private helpers.

### `analyzeFromSources` behavior

The returned `SkillAnalysis` depends on which `ImportSource` values are passed:

| Source | Extra Skills Added |
|---|---|
| `ImportSource.github` | GraphQL (beginner), Redis (beginner) |
| `ImportSource.linkedin` | Agile/Scrum (intermediate), Technical Writing (beginner) |

Always includes 23 base skills across 6 categories.

### Entity: `SkillAnalysis`

| Field | Type | Description |
|---|---|---|
| `overallScore` | `int` | Weighted average proficiency (0--100) |
| `categories` | `List<SkillCategory>` | Skills grouped by category with average proficiency |
| `atsResult` | `ATSResult` | ATS score breakdown and suggestions |
| `missingSkills` | `List<MissingSkill>` | Skills to learn next |
| `courseRecommendations` | `List<CourseRecommendation>` | Suggested courses |
| `careerSuggestions` | `List<CareerSuggestion>` | Matched career paths |
| `salaryEstimate` | `SalaryEstimate` | Expected salary range |
| `learningPlan` | `LearningPlan` | Step-by-step improvement plan |
| `sources` | `List<ImportSource>` | Sources that were analyzed |

### Supporting entities

| Entity | Key Fields |
|---|---|
| `Skill` | `name`, `category`, `level`, `proficiency`, `yearsOfExperience` |
| `SkillCategory` | `type`, `skills`, `averageProficiency` |
| `ATSResult` | `score`, `breakdown`, `suggestions`, `keywordsFound`, `keywordsMissing` |
| `MissingSkill` | `name`, `category`, `importance`, `reason` |
| `CourseRecommendation` | `title`, `provider`, `skillTarget`, `rating`, `duration`, `difficulty`, `url` |
| `CareerSuggestion` | `title`, `matchPercentage`, `requiredSkills`, `yourMatchingSkills`, `salaryRange`, `growthRate` |
| `SalaryEstimate` | `role`, `minSalary`, `maxSalary`, `medianSalary`, `location`, `experienceLevel` |
| `LearningPlan` | `title`, `totalDuration`, `targetRole`, `steps` |

---

## 6. Jobs

**File:** `jobs/data/datasources/job_local_datasource.dart`

### JobLocalDataSource

Pre-loaded with 12 companies and 22 jobs, 6 job applications, 4 job alerts.

| Method | Return Type | Description |
|---|---|---|
| `getJobs()` | `List<Job>` | All available jobs |
| `getApplications()` | `List<JobApplication>` | User's job applications |
| `getAlerts()` | `List<JobAlert>` | Saved job alerts |
| `getSalaryInsight(String title)` | `SalaryInsight` | Salary data for a job title |
| `searchJobs(String query, JobFilter filter)` | `List<Job>` | Full search with query + multi-criteria filter + sorting |
| `getCompanyById(String id)` | `Company?` | Single company by ID |
| `getJobsByCompany(String companyId)` | `List<Job>` | Jobs at a specific company |
| `getJobById(String id)` | `Job?` | Single job by ID |

### `searchJobs` filter & sort

The `JobFilter` object supports:

| Filter Field | Behavior |
|---|---|
| `types` | Filter by `JobType` (fullTime, contract, internship, partTime) |
| `experiences` | Filter by `JobExperience` (entry, mid, senior, executive) |
| `categories` | Filter by `JobCategory` (mobile, softwareEngineering, design, aiMl, etc.) |
| `remoteOnly` | If true, only remote jobs |
| `minSalary` / `maxSalary` | Salary range filter |
| `location` | Substring match on location |
| `sortBy` | `'salary_high'`, `'salary_low'`, `'match'`, or `'recent'` (default) |

### Entity: `Job`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `title` | `String` | Job title |
| `company` | `Company` | Associated company |
| `location` | `String` | Job location |
| `description` | `String` | Full description |
| `requirements` | `List<String>` | Required qualifications |
| `responsibilities` | `List<String>` | Job duties |
| `benefits` | `List<String>` | Perks |
| `skills` | `List<String>` | Required skills |
| `type` | `JobType` | Employment type |
| `experience` | `JobExperience` | Experience level |
| `category` | `JobCategory` | Job category |
| `salaryMin` / `salaryMax` | `int` | Salary range |
| `salaryCurrency` | `String` | Currency code |
| `postedDate` | `String` | Date posted |
| `deadline` | `String` | Application deadline |
| `isRemote` | `bool` | Remote eligibility |
| `isUrgent` | `bool` | Urgent hiring flag |
| `applicants` | `int` | Number of applicants |
| `aiMatchScore` | `int` | AI-computed match score |
| `isSaved` | `bool` | Whether user saved it |

### Supporting entities

| Entity | Key Fields |
|---|---|
| `Company` | `id`, `name`, `logo`, `industry`, `size`, `founded`, `headquarters`, `website`, `description`, `techStack`, `rating`, `reviewCount`, `isVerified` |
| `JobApplication` | `id`, `job`, `status`, `appliedDate`, `lastUpdated`, `notes`, `interviewDate` |
| `JobAlert` | `id`, `title`, `keywords`, `category`, `location`, `minSalary`, `isActive`, `matchCount` |
| `SalaryInsight` | `title`, `average`, `min`, `max`, `p25`, `p75`, `byExperience`, `byLocation` |
| `ApplicationStatus` | enum: `submitted`, `reviewing`, `shortlisted`, `interviewScheduled`, `offered`, `rejected` |

---

## 7. GitHub

**File:** `github/data/datasources/github_local_datasource.dart`

### GithubLocalDataSource

Pre-loaded with 12 trending repos and 6 trending developers.

| Method | Return Type | Description |
|---|---|---|
| `getTrendingRepos()` | `List<GithubRepository>` | All trending repositories |
| `getTrendingDevelopers()` | `List<GithubDeveloper>` | All trending developers |
| `searchRepos(String query)` | `List<GithubRepository>` | Search repos by name, description, language, or topics |

### Entity: `GithubRepository`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `name` | `String` | Repository name |
| `fullName` | `String` | `owner/name` format |
| `description` | `String` | Repo description |
| `owner` | `String` | Owner username |
| `ownerAvatar` | `String` | Avatar initial |
| `language` | `String` | Primary language |
| `languageColor` | `Color` | Language display color |
| `stars` | `int` | Star count |
| `forks` | `int` | Fork count |
| `openIssues` | `int` | Open issues count |
| `watchers` | `int` | Watcher count |
| `createdAt` / `updatedAt` | `String` | Dates |
| `license` | `String` | License type |
| `topics` | `List<String>` | Topic tags |
| `commitActivity` | `List<CommitActivity>` | 12-week commit history |
| `goodFirstIssues` | `List<Issue>` | Good-first-issue items |
| `languageDistribution` | `LanguageDistribution` | Language breakdown |

### Entity: `GithubDeveloper`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `username` | `String` | GitHub handle |
| `displayName` | `String` | Display name |
| `avatar` | `String` | Avatar initial |
| `bio` | `String` | Short bio |
| `company` | `String?` | Company |
| `location` | `String?` | Location |
| `website` | `String?` | Personal website |
| `followers` / `following` | `int` | Follower/following counts |
| `publicRepos` | `int` | Public repos count |
| `contributions` | `int` | Total contributions |
| `popularRepos` | `List<GithubRepository>` | Featured repos |
| `topLanguages` | `List<String>` | Primary languages |
| `isSponsored` | `bool` | Sponsorship badge |
| `contributionGraph` | `List<ContributionDay>` | 365-day contribution graph |

---

## 8. AI Tools

**File:** `ai_tools/data/datasources/ai_tools_local_datasource.dart`

### AiToolsLocalDataSource

Pre-loaded with 24 AI tools across 11 categories.

| Method | Return Type | Description |
|---|---|---|
| `getTools()` | `List<AiTool>` | All tools |
| `getCategories()` | `List<AiToolCategoryInfo>` | All categories with metadata |
| `getReviews(String toolId)` | `List<AiToolReview>` | Reviews for a specific tool (falls back to defaults) |
| `searchTools(String query)` | `List<AiTool>` | Search by name, description, company, or tagline |
| `getToolsByCategory(AiToolCategory)` | `List<AiTool>` | Filter by category |
| `getToolsByPricing(PricingTier)` | `List<AiTool>` | Filter by pricing model |
| `getTrendingTools()` | `List<AiTool>` | Only trending tools |
| `getNewTools()` | `List<AiTool>` | Only new tools |

### Entity: `AiTool`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `name` | `String` | Tool name |
| `tagline` | `String` | Short tagline |
| `description` | `String` | Full description |
| `company` | `String` | Company name |
| `website` | `String` | Official URL |
| `icon` | `IconData` | Display icon |
| `color` | `Color` | Brand color |
| `category` | `AiToolCategory` | Category enum |
| `pricing` | `PricingTier` | Pricing model |
| `priceDisplay` | `String` | Human-readable price |
| `rating` | `double` | Average rating |
| `reviewCount` | `int` | Number of reviews |
| `usageCount` | `int` | Usage count |
| `features` | `List<String>` | Key features |
| `useCases` | `List<String>` | Common use cases |
| `pros` / `cons` | `List<String>` | Pros and cons |
| `isVerified` | `bool` | Verified badge |
| `isNew` | `bool` | New indicator |
| `isTrending` | `bool` | Trending indicator |
| `alternatives` | `List<String>` | Alternative tool IDs |
| `pricingTiers` | `Map<String, String>` | Tier name to price |

### `AiToolCategory` values

`llm`, `imageGeneration`, `codeAssist`, `productivity`, `video`, `audio`, `design`, `research`, `translation`, `automation`, `writing`, `dataScience`

### `PricingTier` values

`free`, `freemium`, `paid`, `enterprise`

### Entity: `AiToolReview`

| Field | Type |
|---|---|
| `id` | `String` |
| `toolId` | `String` |
| `userName` | `String` |
| `userAvatar` | `String` |
| `title` | `String` |
| `content` | `String` |
| `rating` | `double` |
| `date` | `DateTime` |
| `helpfulCount` | `int` |
| `isVerified` | `bool` |

---

## 9. Learning

**File:** `learning/data/datasources/learning_local_datasource.dart`

### LearningLocalDataSource

| Method | Return Type | Description |
|---|---|---|
| `getRoadmaps()` | `List<LearningRoadmap>` | 6 learning roadmaps (Flutter, AI/ML, Backend, DevOps, System Design, Open Source) |
| `getLessons()` | `List<LearningLesson>` | 12 lessons across multiple categories |
| `getVideos()` | `List<LearningVideo>` | 12 educational videos |
| `getNotes()` | `List<LearningNote>` | 12 study notes with bookmarks |
| `getCheatSheets()` | `List<LearningCheatSheet>` | 12 cheat sheets |
| `getDailyChallenges()` | `List<DailyChallenge>` | 6 daily challenges in various statuses |
| `getQuizzes()` | `List<LearningQuiz>` | 12 quizzes with completion tracking |
| `getCertificates()` | `List<LearningCertificate>` | 6 earned certificates |
| `getAchievements()` | `List<LearningAchievement>` | 12 achievements (common through legendary) |
| `getStreakData()` | `LearningStreak` | Streak, XP, level, and 30-day calendar |
| `searchLessons(String query)` | `List<LearningLesson>` | Search lessons by title, description, or category |

### Entities

| Entity | Key Fields |
|---|---|
| `LearningRoadmap` | `id`, `title`, `description`, `icon`, `color`, `totalSteps`, `completedSteps`, `estimatedTime`, `difficulty`, `isLocked`, `steps` |
| `RoadmapStep` | `id`, `title`, `description`, `isCompleted`, `isCurrent`, `lessonId` |
| `LearningLesson` | `id`, `title`, `description`, `category`, `difficulty`, `durationMinutes`, `totalModules`, `completedModules`, `author`, `rating`, `enrolledCount`, `tags` |
| `LearningVideo` | `id`, `title`, `description`, `channel`, `durationMinutes`, `viewCount`, `publishedAt`, `category`, `difficulty`, `rating`, `isWatched` |
| `LearningNote` | `id`, `title`, `content`, `category`, `difficulty`, `pageCount`, `readTimeMinutes`, `isBookmarked`, `lastUpdated`, `author`, `tags` |
| `LearningCheatSheet` | `id`, `title`, `category`, `color`, `itemCount`, `readTimeMinutes`, `difficulty`, `isBookmarked`, `lastUpdated` |
| `DailyChallenge` | `id`, `title`, `description`, `category`, `difficulty`, `points`, `timeLimitMinutes`, `status`, `completedAt`, `expiresAt` |
| `ChallengeStatus` | enum: `pending`, `active`, `completed`, `failed` |
| `LearningQuiz` | `id`, `title`, `description`, `category`, `difficulty`, `questionCount`, `timeLimitMinutes`, `passingScore`, `isCompleted`, `bestScore`, `rating`, `attemptCount` |
| `LearningCertificate` | `id`, `title`, `issuer`, `issuedDate`, `expiryDate`, `credentialId`, `credentialUrl`, `color` |
| `LearningAchievement` | `id`, `title`, `description`, `icon`, `color`, `rarity`, `isUnlocked`, `unlockedAt`, `progress`, `totalRequired` |
| `AchievementRarity` | enum: `common`, `uncommon`, `rare`, `epic`, `legendary` |
| `LearningStreak` | `currentStreak`, `longestStreak`, `totalDaysStudied`, `totalHoursStudied`, `calendarDays`, `todayXP`, `weeklyXP`, `totalXP`, `level`, `xpToNextLevel` |
| `DifficultyLevel` | enum: `beginner`, `intermediate`, `advanced` |

---

## 10. Project Hub

**File:** `project_hub/data/datasources/project_hub_local_datasource.dart`

### ProjectHubLocalDataSource

Pre-loaded with 15 projects spanning web, mobile, backend, ML, DevOps, IoT, blockchain, game dev, and data science.

| Method | Return Type | Description |
|---|---|---|
| `getProjects()` | `List<Project>` | All projects |
| `getFeaturedProjects()` | `List<Project>` | Only featured projects |
| `getNewProjects()` | `List<Project>` | Only new projects |
| `searchProjects(String query)` | `List<Project>` | Search by name, description, technologies, or tags |
| `getProjectsByDifficulty(ProjectDifficulty)` | `List<Project>` | Filter by difficulty |
| `getProjectsByCategory(ProjectCategory)` | `List<Project>` | Filter by category |
| `getProjectsByTechnology(String tech)` | `List<Project>` | Filter by technology |
| `getRecommendations(List<String> userSkills)` | `List<ProjectRecommendation>` | Skill-based project recommendations with match scores |
| `getAllTechnologies()` | `List<String>` | Distinct sorted list of all technologies |

### Entity: `Project`

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `name` | `String` | Project name |
| `description` | `String` | Full description |
| `shortDescription` | `String` | One-liner |
| `difficulty` | `ProjectDifficulty` | easy, medium, hard, advanced |
| `category` | `ProjectCategory` | webApp, mobileApp, apiBackend, fullStack, machineLearning, devOps, dataScience, gameDev, iot, blockchain |
| `technologies` | `List<String>` | Tech stack |
| `githubLink` | `String` | Repository URL |
| `portfolioValue` | `int` | Portfolio impact score |
| `estimatedTime` | `String` | Time estimate |
| `tags` | `List<String>` | Filter tags |
| `isFeatured` / `isNew` | `bool` | Display flags |
| `completionRate` | `int` | Community completion % |
| `rating` | `double` | Average rating |
| `reviewCount` | `int` | Review count |
| `heroColor` | `Color` | Card accent color |
| `icon` | `IconData` | Display icon |
| `buildSteps` | `List<BuildStep>` | Step-by-step build guide |
| `resources` | `List<ProjectResource>` | Learning resources |

### Entity: `ProjectRecommendation`

| Field | Type |
|---|---|
| `project` | `Project` |
| `matchScore` | `int` (20--100) |
| `reasons` | `List<String>` |

---

## 11. Profile

**File:** `profile/data/datasources/profile_local_datasource.dart`

### ProfileLocalDataSource

| Method | Return Type | Description |
|---|---|---|
| `getProfile()` | `UserProfile` | Static user profile |
| `getAchievements()` | `List<Achievement>` | 12 profile achievements (5 unlocked, 7 in progress) |
| `getHistory()` | `List<HistoryItem>` | 10 recent activity items |
| `getBookmarkedJobs()` | `List<BookmarkItem>` | 4 bookmarked jobs |
| `getBookmarkedArticles()` | `List<BookmarkItem>` | 3 bookmarked articles |
| `getBookmarkedProjects()` | `List<BookmarkItem>` | 4 bookmarked projects |
| `getLearningStats()` | `LearningStats` | Aggregated learning metrics |
| `getGitHubStats()` | `GitHubStats` | GitHub contribution stats |
| `getResumeScore()` | `ResumeScore` | Resume analysis with section scores |
| `getThemeSettings()` | `List<ThemeSetting>` | System / Light / Dark options |

### Entities

| Entity | Key Fields |
|---|---|
| `UserProfile` | `name`, `email`, `avatarUrl`, `title`, `location`, `bio`, `joinDate`, `isPremium` |
| `Achievement` | `id`, `title`, `description`, `icon`, `color`, `unlockedAt`, `isUnlocked`, `progress`, `maxProgress` |
| `HistoryItem` | `id`, `title`, `subtitle`, `type`, `timestamp`, `icon` |
| `HistoryItemType` | enum: `lesson`, `job`, `article`, `project`, `quiz`, `skillTest`, `aiChat` |
| `BookmarkItem` | `id`, `title`, `subtitle`, `category`, `savedAt`, `icon` |
| `LearningStats` | `totalLessonsCompleted`, `totalHoursLearned`, `currentStreak`, `longestStreak`, `coursesCompleted`, `quizzesPassed`, `skillsLearned`, `weeklyProgress`, `monthlyProgress` |
| `GitHubStats` | `totalRepos`, `totalStars`, `totalCommits`, `totalPRs`, `totalIssues`, `contributionStreak`, `topLanguages`, `recentActivity` |
| `ResumeScore` | `overallScore`, `atsScore`, `readabilityScore`, `keywordScore`, `formatScore`, `suggestions`, `sectionScores` |
| `ThemeSetting` | `id`, `label`, `icon`, `isActive` |

---

## 12. Home

**File:** `home/data/datasources/home_local_datasource.dart`

### HomeLocalDataSource

| Method | Return Type | Description |
|---|---|---|
| `getTechPulseStats()` | `List<TechPulseStat>` | Dashboard stat cards (articles, skills, commits, streak) |
| `getBreakingNews()` | `List<NewsArticle>` | 4 breaking news items |
| `getTrendingTech()` | `List<TrendingTechnology>` | 6 trending technologies with trend percentages |
| `getTrendingRepos()` | `List<TrendingRepo>` | 4 trending repositories |
| `getTrendingAiTools()` | `List<AiTool>` | 4 trending AI tools |
| `getLatestResearch()` | `List<ResearchPaper>` | 3 latest research papers |
| `getRecommendedJobs()` | `List<JobListing>` | 4 recommended job listings |
| `getUpcomingHackathons()` | `List<Hackathon>` | 3 upcoming hackathons |
| `getFeaturedProjects()` | `List<FeaturedProject>` | 3 featured projects |
| `getContinueLearning()` | `LearningProgress` | Current in-progress course |
| `getQuickActions()` | `List<QuickAction>` | 8 quick-action tiles (Skill Test, Resume, etc.) |

### Entities

| Entity | Key Fields |
|---|---|
| `TechPulseStat` | `label`, `value`, `icon`, `color`, `trend` |
| `NewsArticle` | `id`, `title`, `summary`, `source`, `timeAgo`, `category`, `isBreaking` |
| `TrendingTechnology` | `name`, `trendPercent`, `icon`, `color` |
| `TrendingRepo` | `name`, `fullName`, `description`, `language`, `stars`, `forks`, `periodStars`, `languageColor` |
| `ResearchPaper` | `id`, `title`, `authors`, `abstract`, `publishedDate`, `category`, `citationCount` |
| `JobListing` | `id`, `title`, `company`, `location`, `salary`, `postedAgo`, `isRemote`, `isFeatured`, `tags` |
| `Hackathon` | `id`, `name`, `description`, `startDate`, `prizePool`, `participants`, `color` |
| `FeaturedProject` | `id`, `title`, `description`, `stars`, `forks`, `techStack`, `author` |
| `LearningProgress` | `id`, `courseName`, `category`, `progress`, `lastAccessed`, `totalLessons`, `completedLessons`, `color` |
| `QuickAction` | `label`, `icon`, `color`, `route` |

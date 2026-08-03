class RouteNames {
  RouteNames._();

  // --- Auth ---
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';

  // --- Onboarding Steps ---
  static const String profileSetup = '/onboarding/profile-setup';
  static const String interestSelection = '/onboarding/interests';
  static const String technologySelection = '/onboarding/technologies';
  static const String careerGoal = '/onboarding/career-goal';
  static const String experienceLevel = '/onboarding/experience-level';
  static const String connectGithub = '/onboarding/github';
  static const String uploadResume = '/onboarding/upload-resume';

  // --- Shell (Bottom Nav) ---
  static const String shell = '/';

  // --- Home / News ---
  static const String home = '/';
  static const String newsDetail = '/news/:id';

  // --- AI Assistant ---
  static const String aiAssistant = '/ai-assistant';
  static const String aiChat = '/ai-assistant/chat/:conversationId';

  // --- Jobs ---
  static const String jobs = '/jobs';
  static const String jobDetail = '/jobs/:id';
  static const String jobCompany = '/jobs/company/:companyId';
  static const String jobApply = '/jobs/apply/:id';
  static const String jobSalaryInsights = '/jobs/salary-insights/:title';
  static const String jobRecruiterContact = '/jobs/contact/:jobId';
  static const String jobAlerts = '/jobs/alerts';
  static const String savedJobs = '/jobs/saved';
  static const String jobApplications = '/jobs/applications';

  // --- More (placeholder for remaining tabs) ---
  static const String more = '/more';

  // --- Profile ---
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String profileBookmarks = '/profile/bookmarks';
  static const String profileHistory = '/profile/history';
  static const String profileAchievements = '/profile/achievements';
  static const String profileLearningStats = '/profile/learning-stats';
  static const String profileGitHubStats = '/profile/github-stats';
  static const String profileResumeScore = '/profile/resume-score';
  static const String profileThemeSettings = '/profile/theme-settings';
  static const String profileAccountSettings = '/profile/account-settings';

  // --- Bookmarks ---
  static const String bookmarks = '/bookmarks';

  // --- Search ---
  static const String search = '/search';

  // --- Notifications ---
  static const String notifications = '/notifications';

  // --- Settings ---
  static const String settings = '/settings';

  // --- Feature Routes (added as features are built) ---
  static const String explore = '/explore';
  static const String exploreCategory = '/explore/category/:categoryName';
  static const String exploreArticle = '/explore/article/:articleId';
  static const String skillAnalyzer = '/skill-analyzer';
  static const String internships = '/internships';
  static const String githubSearch = '/github/search';
  static const String githubRepoDetail = '/github/repo/:repoId';
  static const String githubDevDetail = '/github/dev/:devId';
  static const String githubTrendingRepos = '/github/trending-repos';
  static const String githubTrendingDevs = '/github/trending-devs';
  static const String learningHub = '/learning-hub';
  static const String learningRoadmaps = '/learning/roadmaps';
  static const String learningRoadmapDetail = '/learning/roadmap/:roadmapId';
  static const String learningLessons = '/learning/lessons';
  static const String learningLessonDetail = '/learning/lesson/:lessonId';
  static const String learningVideos = '/learning/videos';
  static const String learningNotes = '/learning/notes';
  static const String learningCheatSheets = '/learning/cheat-sheets';
  static const String learningChallenges = '/learning/challenges';
  static const String learningQuizzes = '/learning/quizzes';
  static const String learningQuizDetail = '/learning/quiz/:quizId';
  static const String learningCertificates = '/learning/certificates';
  static const String learningAchievements = '/learning/achievements';
  static const String learningStreaks = '/learning/streaks';
  static const String projectHub = '/project-hub';
  static const String projectDetail = '/project-hub/:projectId';
  static const String projectRecommendations = '/project-hub/recommendations';
  static const String resumeBuilder = '/resume-builder';
  static const String atsAnalyzer = '/ats-analyzer';
  static const String interviewPrep = '/interview-prep';
  static const String aiToolsDirectory = '/ai-tools';
  static const String aiToolDetail = '/ai-tools/:toolId';
  static const String aiToolsCompare = '/ai-tools/compare';
  static const String aiToolsBookmarks = '/ai-tools/bookmarks';
  static const String hackathons = '/hackathons';
  static const String researchPapers = '/research-papers';
  static const String startupNews = '/startup-news';
  static const String devUtilities = '/dev-utilities';
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/auth_state.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/providers/auth_provider.dart' as supabase_auth;
import '../../features/auth/presentation/screens/connect_github_screen.dart';
import '../../features/auth/presentation/screens/career_goal_screen.dart';
import '../../features/auth/presentation/screens/experience_level_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/interest_selection_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/profile_setup_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/technology_selection_screen.dart';
import '../../features/auth/presentation/screens/upload_resume_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/explore/presentation/screens/explore_category_detail_screen.dart';
import '../../features/explore/presentation/screens/explore_article_detail_screen.dart';
import '../../features/ai_assistant/presentation/screens/chat_screen.dart';
import '../../features/ai_assistant/presentation/screens/conversation_history_screen.dart';
import '../../features/skill_analyzer/presentation/screens/skill_analyzer_screen.dart';
import '../../features/jobs/presentation/screens/jobs_screen.dart';
import '../../features/jobs/presentation/screens/job_detail_screen.dart';
import '../../features/jobs/presentation/screens/company_detail_screen.dart';
import '../../features/jobs/presentation/screens/saved_jobs_screen.dart';
import '../../features/jobs/presentation/screens/applications_screen.dart';
import '../../features/jobs/presentation/screens/job_alerts_screen.dart';
import '../../features/jobs/presentation/screens/salary_insights_screen.dart';
import '../../features/jobs/presentation/screens/recruiter_contact_screen.dart';
import '../../features/jobs/presentation/screens/application_form_screen.dart';
import '../../features/github/presentation/screens/trending_repos_screen.dart';
import '../../features/github/presentation/screens/trending_developers_screen.dart';
import '../../features/github/presentation/screens/repository_detail_screen.dart';
import '../../features/github/presentation/screens/developer_detail_screen.dart';
import '../../features/github/presentation/screens/github_search_screen.dart';
import '../../features/learning/presentation/screens/learning_hub_screen.dart';
import '../../features/learning/presentation/screens/roadmaps_screen.dart';
import '../../features/learning/presentation/screens/roadmap_detail_screen.dart';
import '../../features/learning/presentation/screens/lessons_screen.dart';
import '../../features/learning/presentation/screens/lesson_detail_screen.dart';
import '../../features/learning/presentation/screens/videos_screen.dart';
import '../../features/learning/presentation/screens/notes_screen.dart';
import '../../features/learning/presentation/screens/cheat_sheets_screen.dart';
import '../../features/learning/presentation/screens/daily_challenges_screen.dart';
import '../../features/learning/presentation/screens/quizzes_screen.dart';
import '../../features/learning/presentation/screens/quiz_detail_screen.dart';
import '../../features/learning/presentation/screens/certificates_screen.dart';
import '../../features/learning/presentation/screens/streaks_screen.dart';
import '../../features/ai_tools/presentation/screens/ai_tools_directory_screen.dart';
import '../../features/ai_tools/presentation/screens/tool_detail_screen.dart';
import '../../features/ai_tools/presentation/screens/compare_tools_screen.dart';
import '../../features/ai_tools/presentation/screens/bookmarked_tools_screen.dart';
import '../../features/project_hub/presentation/screens/project_hub_screen.dart';
import '../../features/project_hub/presentation/screens/project_detail_screen.dart';
import '../../features/project_hub/presentation/screens/project_recommendations_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/achievements_screen.dart';
import '../../features/profile/presentation/screens/bookmarks_screen.dart';
import '../../features/profile/presentation/screens/history_screen.dart';
import '../../features/profile/presentation/screens/learning_stats_screen.dart';
import '../../features/profile/presentation/screens/github_stats_screen.dart';
import '../../features/profile/presentation/screens/resume_score_screen.dart';
import '../../features/profile/presentation/screens/theme_settings_screen.dart';
import '../../features/profile/presentation/screens/account_settings_screen.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Routes guests may visit without a session. Every other route requires an
/// authenticated Supabase session.
const _guestRoutes = <String>{
  RouteNames.login,
  RouteNames.register,
  RouteNames.forgotPassword,
  RouteNames.otpVerification,
};

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(this._ref);

  final Ref _ref;
  AuthState get authState => _ref.read(authProvider);

  void refresh() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _AuthRefreshNotifier(ref);

  ref.listen(
    supabase_auth.authStateProvider,
    (previous, next) => refreshNotifier.refresh(),
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(supabase_auth.authStateProvider).value;
      // Session still resolving (cold start / session restore): hold on the
      // splash instead of flashing a wrong destination.
      if (authState == null) return null;

      final location = state.uri.path;
      // Splash is the launch gate: route once the session has resolved.
      if (location == RouteNames.splash) {
        return authState.session != null
            ? RouteNames.home
            : RouteNames.login;
      }

      final isAuthenticated = authState.session != null;
      final isGuestRoute = _guestRoutes.contains(location);

      if (isAuthenticated && isGuestRoute) return RouteNames.home;
      if (!isAuthenticated && !isGuestRoute) return RouteNames.login;
      return null;
    },
    routes: [
      // --- Splash ---
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // --- Auth Routes ---
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return OtpVerificationScreen(email: email);
        },
      ),

      // --- Onboarding ---
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // --- Onboarding Steps ---
      GoRoute(
        path: RouteNames.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: RouteNames.interestSelection,
        builder: (context, state) => const InterestSelectionScreen(),
      ),
      GoRoute(
        path: RouteNames.technologySelection,
        builder: (context, state) => const TechnologySelectionScreen(),
      ),
      GoRoute(
        path: RouteNames.careerGoal,
        builder: (context, state) => const CareerGoalScreen(),
      ),
      GoRoute(
        path: RouteNames.experienceLevel,
        builder: (context, state) => const ExperienceLevelScreen(),
      ),
      GoRoute(
        path: RouteNames.connectGithub,
        builder: (context, state) => const ConnectGithubScreen(),
      ),
      GoRoute(
        path: RouteNames.uploadResume,
        builder: (context, state) => const UploadResumeScreen(),
      ),

      // --- Shell Route (Bottom Nav) ---
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithNav(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.jobs,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: JobsScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.bookmarks,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookmarksScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.more,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoreScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // --- Standalone Routes ---
      GoRoute(
        path: RouteNames.aiAssistant,
        builder: (context, state) => const ConversationHistoryScreen(),
      ),
      GoRoute(
        path: RouteNames.aiChat,
        builder: (context, state) {
          final conversationId = state.pathParameters['conversationId'];
          return ChatScreen(conversationId: conversationId);
        },
      ),
      GoRoute(
        path: RouteNames.explore,
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: RouteNames.exploreCategory,
        builder: (context, state) {
          final categoryName = state.pathParameters['categoryName'] ?? '';
          return ExploreCategoryDetailScreen(categoryName: categoryName);
        },
      ),
      GoRoute(
        path: RouteNames.exploreArticle,
        builder: (context, state) {
          final articleId = state.pathParameters['articleId'] ?? '';
          return ExploreArticleDetailScreen(articleId: articleId);
        },
      ),
      GoRoute(
        path: RouteNames.skillAnalyzer,
        builder: (context, state) => const SkillAnalyzerScreen(),
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.profileBookmarks,
        builder: (context, state) => const BookmarksScreen(),
      ),
      GoRoute(
        path: RouteNames.profileHistory,
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: RouteNames.profileAchievements,
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: RouteNames.profileLearningStats,
        builder: (context, state) => const LearningStatsScreen(),
      ),
      GoRoute(
        path: RouteNames.profileGitHubStats,
        builder: (context, state) => const GitHubStatsScreen(),
      ),
      GoRoute(
        path: RouteNames.profileResumeScore,
        builder: (context, state) => const ResumeScoreScreen(),
      ),
      GoRoute(
        path: RouteNames.profileThemeSettings,
        builder: (context, state) => const ThemeSettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.profileAccountSettings,
        builder: (context, state) => const AccountSettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.notifications,
        builder: (context, state) => const PlaceholderScreen(title: 'Notifications'),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const PlaceholderScreen(title: 'Settings'),
      ),
      GoRoute(
        path: RouteNames.search,
        builder: (context, state) => const PlaceholderScreen(title: 'Search'),
      ),

      // --- Job Portal Routes ---
      GoRoute(
        path: RouteNames.jobDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return JobDetailScreen(jobId: id);
        },
      ),
      GoRoute(
        path: RouteNames.jobCompany,
        builder: (context, state) {
          final companyId = state.pathParameters['companyId'] ?? '';
          return CompanyDetailScreen(companyId: companyId);
        },
      ),
      GoRoute(
        path: RouteNames.jobApply,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ApplicationFormScreen(jobId: id);
        },
      ),
      GoRoute(
        path: RouteNames.jobSalaryInsights,
        builder: (context, state) {
          final title = state.pathParameters['title'] ?? '';
          return SalaryInsightsScreen(jobTitle: title);
        },
      ),
      GoRoute(
        path: RouteNames.jobRecruiterContact,
        builder: (context, state) {
          final jobId = state.pathParameters['jobId'] ?? '';
          return RecruiterContactScreen(jobId: jobId);
        },
      ),
      GoRoute(
        path: RouteNames.jobAlerts,
        builder: (context, state) => const JobAlertsScreen(),
      ),
      GoRoute(
        path: RouteNames.savedJobs,
        builder: (context, state) => const SavedJobsScreen(),
      ),
      GoRoute(
        path: RouteNames.jobApplications,
        builder: (context, state) => const ApplicationsScreen(),
      ),

      // --- GitHub Explorer Routes ---
      GoRoute(
        path: RouteNames.githubTrendingRepos,
        builder: (context, state) => const TrendingReposScreen(),
      ),
      GoRoute(
        path: RouteNames.githubTrendingDevs,
        builder: (context, state) => const TrendingDevelopersScreen(),
      ),
      GoRoute(
        path: RouteNames.githubRepoDetail,
        builder: (context, state) {
          final repoId = state.pathParameters['repoId'] ?? '';
          return RepositoryDetailScreen(repoId: repoId);
        },
      ),
      GoRoute(
        path: RouteNames.githubDevDetail,
        builder: (context, state) {
          final devId = state.pathParameters['devId'] ?? '';
          return DeveloperDetailScreen(devId: devId);
        },
      ),
      GoRoute(
        path: RouteNames.githubSearch,
        builder: (context, state) => const GitHubSearchScreen(),
      ),

      // --- Learning Hub Routes ---
      GoRoute(
        path: RouteNames.learningHub,
        builder: (context, state) => const LearningHubScreen(),
      ),
      GoRoute(
        path: RouteNames.learningRoadmaps,
        builder: (context, state) => const RoadmapsScreen(),
      ),
      GoRoute(
        path: RouteNames.learningRoadmapDetail,
        builder: (context, state) {
          final roadmapId = state.pathParameters['roadmapId'] ?? '';
          return RoadmapDetailScreen(roadmapId: roadmapId);
        },
      ),
      GoRoute(
        path: RouteNames.learningLessons,
        builder: (context, state) => const LessonsScreen(),
      ),
      GoRoute(
        path: RouteNames.learningLessonDetail,
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId'] ?? '';
          return LessonDetailScreen(lessonId: lessonId);
        },
      ),
      GoRoute(
        path: RouteNames.learningVideos,
        builder: (context, state) => const VideosScreen(),
      ),
      GoRoute(
        path: RouteNames.learningNotes,
        builder: (context, state) => const NotesScreen(),
      ),
      GoRoute(
        path: RouteNames.learningCheatSheets,
        builder: (context, state) => const CheatSheetsScreen(),
      ),
      GoRoute(
        path: RouteNames.learningChallenges,
        builder: (context, state) => const DailyChallengesScreen(),
      ),
      GoRoute(
        path: RouteNames.learningQuizzes,
        builder: (context, state) => const QuizzesScreen(),
      ),
      GoRoute(
        path: RouteNames.learningQuizDetail,
        builder: (context, state) {
          final quizId = state.pathParameters['quizId'] ?? '';
          return QuizDetailScreen(quizId: quizId);
        },
      ),
      GoRoute(
        path: RouteNames.learningCertificates,
        builder: (context, state) => const CertificatesScreen(),
      ),
      GoRoute(
        path: RouteNames.learningAchievements,
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: RouteNames.learningStreaks,
        builder: (context, state) => const StreaksScreen(),
      ),

      // --- Project Hub Routes ---
      GoRoute(
        path: RouteNames.projectRecommendations,
        builder: (context, state) => const ProjectRecommendationsScreen(),
      ),
      GoRoute(
        path: RouteNames.projectHub,
        builder: (context, state) => const ProjectHubScreen(),
      ),
      GoRoute(
        path: RouteNames.projectDetail,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'] ?? '';
          return ProjectDetailScreen(projectId: projectId);
        },
      ),

      // --- AI Tools Directory Routes ---
      GoRoute(
        path: RouteNames.aiToolsDirectory,
        builder: (context, state) => const AiToolsDirectoryScreen(),
      ),
      GoRoute(
        path: RouteNames.aiToolDetail,
        builder: (context, state) {
          final toolId = state.pathParameters['toolId'] ?? '';
          return ToolDetailScreen(toolId: toolId);
        },
      ),
      GoRoute(
        path: RouteNames.aiToolsCompare,
        builder: (context, state) => const CompareToolsScreen(),
      ),
      GoRoute(
        path: RouteNames.aiToolsBookmarks,
        builder: (context, state) => const BookmarkedToolsScreen(),
      ),
    ],
  );
});

// ==================== SHELL SCAFFOLD ====================

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline_rounded),
            selectedIcon: Icon(Icons.work_rounded),
            label: 'Jobs',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'More',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/jobs')) return 1;
    if (location.startsWith('/bookmarks')) return 2;
    if (location.startsWith('/profile')) return 4;
    if (location.startsWith('/more')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
      case 1:
        context.go(RouteNames.jobs);
      case 2:
        context.go(RouteNames.bookmarks);
      case 3:
        context.go(RouteNames.more);
      case 4:
        context.go(RouteNames.profile);
    }
  }
}

// ==================== PLACEHOLDER ====================

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

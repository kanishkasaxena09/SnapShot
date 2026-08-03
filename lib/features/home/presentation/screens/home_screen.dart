import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../data/datasources/home_local_datasource.dart';
import '../widgets/breaking_news_card.dart';
import '../widgets/daily_tech_pulse.dart';
import '../widgets/featured_project_card.dart';
import '../widgets/floating_ai_button.dart';
import '../widgets/greeting_header.dart';
import '../widgets/hackathon_card.dart';
import '../widgets/learning_continue_card.dart';
import '../widgets/learning_hub_section.dart';
import '../widgets/recommended_job_card.dart';
import '../widgets/research_card.dart';
import '../widgets/trending_ai_tools_card.dart';
import '../widgets/trending_github_card.dart';
import '../widgets/trending_tech_card.dart';

final _dataSource = HomeLocalDataSource();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),
            SliverToBoxAdapter(
              child: const GreetingHeader(
                userName: 'Developer',
                notificationCount: 3,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: DailyTechPulse(
                  stats: _dataSource.getTechPulseStats(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            const SliverToBoxAdapter(
              child: RepaintBoundary(child: LearningHubSection()),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: BreakingNewsSection(
                  articles: _dataSource.getBreakingNews(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: TrendingTechSection(
                  technologies: _dataSource.getTrendingTech(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: TrendingGithubSection(
                  repos: _dataSource.getTrendingRepos(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: TrendingAiToolsSection(
                  tools: _dataSource.getTrendingAiTools(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: ResearchSection(
                  papers: _dataSource.getLatestResearch(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: RecommendedJobsSection(
                  jobs: _dataSource.getRecommendedJobs(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: HackathonSection(
                  hackathons: _dataSource.getUpcomingHackathons(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: FeaturedProjectsSection(
                  projects: _dataSource.getFeaturedProjects(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: LearningContinueCard(
                  progress: _dataSource.getContinueLearning(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxxl),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingAIButton(),
    );
  }
}

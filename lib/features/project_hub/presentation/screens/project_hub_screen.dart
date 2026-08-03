import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/project_entities.dart';
import '../providers/project_hub_providers.dart';
import '../widgets/project_card.dart';

class ProjectHubScreen extends ConsumerStatefulWidget {
  const ProjectHubScreen({super.key});

  @override
  ConsumerState<ProjectHubScreen> createState() => _ProjectHubScreenState();
}

class _ProjectHubScreenState extends ConsumerState<ProjectHubScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final projects = ref.watch(allProjectsProvider);
    final technologies = ref.watch(allTechnologiesProvider);
    final selectedDifficulty = ref.watch(projectDifficultyFilterProvider);
    final selectedCategory = ref.watch(projectCategoryFilterProvider);
    final selectedTech = ref.watch(projectTechnologyFilterProvider);
    final searchQuery = ref.watch(projectSearchQueryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Project Hub', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: const Icon(Icons.recommend_outlined, size: 22),
            onPressed: () => context.push('/project-hub/recommendations'),
            tooltip: 'Get Recommendations',
          ),
        ],
      ),
      body: RefreshIndicator(
        color: colorScheme.primary,
        backgroundColor: colorScheme.surface,
        onRefresh: () async => ref.invalidate(allProjectsProvider),
        child: Semantics(
          label: 'Project Hub. ${projects.length} projects available.',
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.md, AppSpacing.base, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => ref.read(projectSearchQueryProvider.notifier).state = v,
                    decoration: InputDecoration(
                      hintText: 'Search projects, technologies...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(projectSearchQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusLg,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Difficulty Filter
                  Text('Difficulty', style: AppTypography.labelMedium(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.xs),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ProjectDifficulty.values.map((d) {
                        final selected = selectedDifficulty == d;
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: FilterChip(
                            label: Text(d.name[0].toUpperCase() + d.name.substring(1)),
                            selected: selected,
                            onSelected: (v) {
                              ref.read(projectDifficultyFilterProvider.notifier).state = v ? d : null;
                            },
                            selectedColor: colorScheme.primary.withValues(alpha: 0.15),
                            checkmarkColor: colorScheme.primary,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Technology Filter
                  Text('Technology', style: AppTypography.labelMedium(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: technologies.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (_, i) {
                        final tech = technologies[i];
                        final selected = selectedTech == tech;
                        return FilterChip(
                          label: Text(tech),
                          selected: selected,
                          onSelected: (v) {
                            ref.read(projectTechnologyFilterProvider.notifier).state = v ? tech : null;
                          },
                          selectedColor: colorScheme.primary.withValues(alpha: 0.15),
                          checkmarkColor: colorScheme.primary,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Sort & Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${projects.length} projects', style: AppTypography.bodyMedium(color: colorScheme.onSurfaceVariant)),
                      DropdownButton<String>(
                        value: ref.watch(projectSortProvider),
                        underline: const SizedBox(),
                        isDense: true,
                        items: const [
                          DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
                          DropdownMenuItem(value: 'portfolio', child: Text('Portfolio Value')),
                          DropdownMenuItem(value: 'newest', child: Text('Newest')),
                          DropdownMenuItem(value: 'name', child: Text('Name')),
                        ],
                        onChanged: (v) {
                          if (v != null) ref.read(projectSortProvider.notifier).state = v;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ),

          // Featured Section
          if (searchQuery.isEmpty && selectedDifficulty == null && selectedCategory == null && selectedTech == null) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.base, 0, AppSpacing.base, AppSpacing.sm),
                child: Text('Featured Projects', style: AppTypography.titleLarge(color: colorScheme.onSurface)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 165,
                child: Consumer(
                  builder: (_, ref, __) {
                    final featured = ref.watch(featuredProjectsProvider);
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      scrollDirection: Axis.horizontal,
                      itemCount: featured.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                      itemBuilder: (_, i) => ProjectHorizontalCard(project: featured[i]),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: AppSpacing.md)),
          ],

          // Project Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            sliver: projects.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(Icons.search_off, size: 64, color: colorScheme.outlineVariant),
                          const SizedBox(height: AppSpacing.md),
                          Text('No projects found', style: AppTypography.titleMedium(color: colorScheme.onSurfaceVariant)),
                          const SizedBox(height: AppSpacing.xs),
                          Text('Try adjusting your filters', style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => RepaintBoundary(
                        child: ProjectCard(project: projects[i]),
                      ),
                      childCount: projects.length,
                    ),
                  ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
        ],
      ),
      ),
      ),
    );
  }
}

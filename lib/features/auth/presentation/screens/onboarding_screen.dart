import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPage(
      title: 'Stay Ahead',
      description: 'Get the latest tech news, trends, and insights curated just for you.',
      icon: Icons.newspaper_rounded,
      color: Color(0xFF6C63FF),
    ),
    _OnboardingPage(
      title: 'AI-Powered Tools',
      description: 'Smart resume builder, interview prep, and career guidance at your fingertips.',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFF00D9A6),
    ),
    _OnboardingPage(
      title: 'Grow Your Career',
      description: 'Find jobs, internships, hackathons, and connect with the tech community.',
      icon: Icons.rocket_launch_rounded,
      color: Color(0xFFFF6B6B),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go(RouteNames.login),
                child: Text(
                  'Skip',
                  style: AppTypography.labelLarge(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: page.color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 60,
                            color: page.color,
                          ),
                        ).animate().scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1, 1),
                              curve: Curves.easeOutBack,
                            ),
                        const SizedBox(height: AppSpacing.xxxl),
                        Text(
                          page.title,
                          style: AppTypography.headlineLarge(
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          page.description,
                          style: AppTypography.bodyLarge(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? colorScheme.primary
                              : colorScheme.surfaceContainerHighest,
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  FilledButton(
                    onPressed: _onNext,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

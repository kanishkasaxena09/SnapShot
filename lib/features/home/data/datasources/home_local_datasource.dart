import 'package:flutter/material.dart';

import '../models/home_models.dart';
import '../../../../core/theme/app_colors.dart';

class HomeLocalDataSource {
  List<TechPulseStat> getTechPulseStats() => const [
        TechPulseStat(label: 'Articles', value: '12', icon: Icons.article_outlined, color: AppColors.primaryLight, trend: 15.0),
        TechPulseStat(label: 'Skills', value: '5', icon: Icons.psychology_outlined, color: AppColors.secondaryLight, trend: 8.0),
        TechPulseStat(label: 'Commits', value: '34', icon: Icons.code_rounded, color: AppColors.accentOrange, trend: 22.0),
        TechPulseStat(label: 'Streak', value: '7d', icon: Icons.local_fire_department_rounded, color: AppColors.tertiaryLight, trend: 100.0),
      ];

  List<NewsArticle> getBreakingNews() => const [
        NewsArticle(
          id: '1',
          title: 'GPT-5 Release Date Confirmed by OpenAI',
          summary: 'OpenAI announces the official release timeline for GPT-5, promising a major leap in reasoning capabilities.',
          source: 'TechCrunch',
          timeAgo: '2h ago',
          category: 'AI',
          isBreaking: true,
        ),
        NewsArticle(
          id: '2',
          title: 'Flutter 4.0 Introduces Revolutionary Rendering Engine',
          summary: 'The next major Flutter release brings a new rendering backend with 2x performance improvements.',
          source: 'Flutter Blog',
          timeAgo: '4h ago',
          category: 'Mobile',
        ),
        NewsArticle(
          id: '3',
          title: 'Rust Overtakes Go in Developer Satisfaction Survey',
          summary: 'Stack Overflow 2026 survey shows Rust as the most loved language for the 9th consecutive year.',
          source: 'Stack Overflow',
          timeAgo: '6h ago',
          category: 'Languages',
        ),
        NewsArticle(
          id: '4',
          title: 'GitHub Copilot X Gets Real-time Code Review',
          summary: 'New AI-powered code review feature catches bugs before they reach production.',
          source: 'GitHub Blog',
          timeAgo: '8h ago',
          category: 'DevTools',
        ),
      ];

  List<TrendingTechnology> getTrendingTech() => const [
        TrendingTechnology(name: 'Rust', trendPercent: 12.5, icon: Icons.code_rounded, color: AppColors.accentOrange),
        TrendingTechnology(name: 'AI/ML', trendPercent: 28.3, icon: Icons.smart_toy_rounded, color: AppColors.primaryLight),
        TrendingTechnology(name: 'Flutter', trendPercent: 9.7, icon: Icons.phone_android_rounded, color: AppColors.accentCyan),
        TrendingTechnology(name: 'Web3', trendPercent: -3.2, icon: Icons.web_rounded, color: AppColors.secondaryLight),
        TrendingTechnology(name: 'Kotlin', trendPercent: 15.1, icon: Icons.android_rounded, color: AppColors.accentPink),
        TrendingTechnology(name: 'Go', trendPercent: 6.8, icon: Icons.speed_rounded, color: AppColors.accentBlue),
      ];

  List<TrendingRepo> getTrendingRepos() => const [
        TrendingRepo(
          name: 'uv',
          fullName: 'astral-sh/uv',
          description: 'An extremely fast Python package installer and resolver',
          language: 'Rust',
          stars: 42800,
          forks: 1200,
          periodStars: 2100,
          languageColor: AppColors.accentOrange,
        ),
        TrendingRepo(
          name: 'shadcn-ui',
          fullName: 'shadcn-ui/ui',
          description: 'Beautifully designed components built with Radix UI and Tailwind CSS',
          language: 'TypeScript',
          stars: 76500,
          forks: 5300,
          periodStars: 1850,
          languageColor: AppColors.accentBlue,
        ),
        TrendingRepo(
          name: 'ollama',
          fullName: 'ollama/ollama',
          description: 'Get up and running with Llama 3.1, Mistral, Gemma 2, and other large language models',
          language: 'Go',
          stars: 98200,
          forks: 7600,
          periodStars: 1650,
          languageColor: AppColors.accentCyan,
        ),
        TrendingRepo(
          name: 'open-webui',
          fullName: 'open-webui/open-webui',
          description: 'User-friendly AI Interface (Supports Ollama, OpenAI API)',
          language: 'JavaScript',
          stars: 51200,
          forks: 6400,
          periodStars: 1400,
          languageColor: AppColors.accentYellow,
        ),
      ];

  List<AiTool> getTrendingAiTools() => const [
        AiTool(
          id: '1',
          name: 'Claude 3.5',
          description: 'Advanced reasoning and analysis by Anthropic',
          category: 'LLM',
          rating: 4.8,
          icon: Icons.auto_awesome_rounded,
          color: AppColors.primaryLight,
        ),
        AiTool(
          id: '2',
          name: 'Midjourney V7',
          description: 'Next-gen image generation with photorealism',
          category: 'Image Gen',
          rating: 4.7,
          icon: Icons.palette_rounded,
          color: AppColors.accentPink,
        ),
        AiTool(
          id: '3',
          name: 'Cursor IDE',
          description: 'AI-first code editor with multi-file editing',
          category: 'Coding',
          rating: 4.9,
          icon: Icons.terminal_rounded,
          color: AppColors.secondaryLight,
          isNew: true,
        ),
        AiTool(
          id: '4',
          name: 'Perplexity',
          description: 'AI-powered research and search engine',
          category: 'Search',
          rating: 4.6,
          icon: Icons.search_rounded,
          color: AppColors.accentBlue,
        ),
      ];

  List<ResearchPaper> getLatestResearch() => const [
        ResearchPaper(
          id: '1',
          title: 'Scaling Laws for Neural Language Models Revisited',
          authors: 'Kaplan et al.',
          abstract: 'We revisit the scaling laws framework and present new findings on compute-optimal training for LLMs.',
          publishedDate: 'Jul 15, 2026',
          category: 'NLP',
          citationCount: 342,
        ),
        ResearchPaper(
          id: '2',
          title: 'Efficient Fine-tuning with LoRA++',
          authors: 'Hu et al.',
          abstract: 'An improved low-rank adaptation method achieving 95% of full fine-tuning quality at 0.1% compute.',
          publishedDate: 'Jul 12, 2026',
          category: 'ML',
          citationCount: 189,
        ),
        ResearchPaper(
          id: '3',
          title: 'Vision Transformers for Code Understanding',
          authors: 'Zhang et al.',
          abstract: 'Novel architecture combining vision and language models for program comprehension and generation.',
          publishedDate: 'Jul 10, 2026',
          category: 'SE + AI',
          citationCount: 67,
        ),
      ];

  List<JobListing> getRecommendedJobs() => const [
        JobListing(
          id: '1',
          title: 'Senior Flutter Developer',
          company: 'Google',
          location: 'Mountain View, CA',
          salary: '\$180k - \$250k',
          postedAgo: '1d ago',
          isRemote: false,
          isFeatured: true,
          tags: ['Flutter', 'Dart', 'Firebase'],
        ),
        JobListing(
          id: '2',
          title: 'ML Engineer',
          company: 'OpenAI',
          location: 'Remote',
          salary: '\$200k - \$350k',
          postedAgo: '3d ago',
          isRemote: true,
          isFeatured: true,
          tags: ['Python', 'PyTorch', 'LLMs'],
        ),
        JobListing(
          id: '3',
          title: 'Full Stack Developer',
          company: 'Stripe',
          location: 'San Francisco, CA',
          salary: '\$160k - \$220k',
          postedAgo: '5d ago',
          isRemote: true,
          tags: ['React', 'Node.js', 'TypeScript'],
        ),
        JobListing(
          id: '4',
          title: 'DevOps Engineer',
          company: 'Netflix',
          location: 'Los Gatos, CA',
          salary: '\$190k - \$280k',
          postedAgo: '2d ago',
          isRemote: false,
          tags: ['Kubernetes', 'AWS', 'Terraform'],
        ),
      ];

  List<Hackathon> getUpcomingHackathons() => const [
        Hackathon( 
          id: '1',
          name: 'AI for Good Hackathon',
          description: 'Build AI solutions for social impact challenges',
          startDate: 'Aug 1, 2026',
          prizePool: '\$50,000',
          participants: 1240,
          color: AppColors.primaryLight,
        ),
        Hackathon(
          id: '2',
          name: 'Flutter Forward Hack',
          description: 'Push the boundaries of cross-platform development',
          startDate: 'Aug 15, 2026',
          prizePool: '\$25,000',
          participants: 890,
          color: AppColors.accentCyan,
        ),
        Hackathon(
          id: '3',
          name: 'Web3 Build Week',
          description: 'Decentralize everything. Build the future of the internet.',
          startDate: 'Sep 1, 2026',
          prizePool: '\$100,000',
          participants: 2100,
          color: AppColors.secondaryLight,
        ),
      ];

  List<FeaturedProject> getFeaturedProjects() => const [
        FeaturedProject(
          id: '1',
          title: 'DevFlow',
          description: 'AI-powered development workflow assistant that automates code reviews and CI/CD pipelines.',
          stars: 4200,
          forks: 380,
          techStack: ['Flutter', 'Dart', 'Python', 'GPT-4'],
          author: 'sarahdev',
        ),
        FeaturedProject(
          id: '2',
          title: 'PixelForge',
          description: 'Real-time collaborative design tool with AI-assisted layout suggestions.',
          stars: 2800,
          forks: 210,
          techStack: ['React', 'WebGL', 'Rust', 'WASM'],
          author: 'pixelmaster',
        ),
        FeaturedProject(
          id: '3',
          title: 'DataPilot',
          description: 'Natural language to SQL query engine for non-technical analysts.',
          stars: 5600,
          forks: 420,
          techStack: ['Python', 'FastAPI', 'PostgreSQL', 'LLM'],
          author: 'datawizard',
        ),
      ];

  LearningProgress getContinueLearning() => const LearningProgress(
        id: '1',
        courseName: 'Advanced Flutter State Management',
        category: 'Mobile Development',
        progress: 0.65,
        lastAccessed: '2 hours ago',
        totalLessons: 24,
        completedLessons: 16,
        color: AppColors.primaryLight,
      );

  List<QuickAction> getQuickActions() => const [
        QuickAction(label: 'Skill Test', icon: Icons.psychology_outlined, color: AppColors.primaryLight, route: '/skill-analyzer'),
        QuickAction(label: 'Resume', icon: Icons.description_outlined, color: AppColors.secondaryLight, route: '/resume-builder'),
        QuickAction(label: 'Interview', icon: Icons.record_voice_over_outlined, color: AppColors.accentOrange, route: '/interview-prep'),
        QuickAction(label: 'ATS Score', icon: Icons.analytics_outlined, color: AppColors.accentPink, route: '/ats-analyzer'),
        QuickAction(label: 'Learn', icon: Icons.school_outlined, color: AppColors.accentBlue, route: '/learning-hub'),
        QuickAction(label: 'Projects', icon: Icons.folder_outlined, color: AppColors.accentCyan, route: '/project-hub'),
        QuickAction(label: 'GitHub', icon: Icons.code_rounded, color: AppColors.accentYellow, route: '/github/trending-repos'),
        QuickAction(label: 'AI Tools', icon: Icons.smart_toy_outlined, color: AppColors.accentPink, route: '/ai-tools'),
      ];
}

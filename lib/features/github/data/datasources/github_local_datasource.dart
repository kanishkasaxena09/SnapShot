import 'package:flutter/material.dart';
import '../../domain/entities/github_entities.dart';

class GithubLocalDataSource {
  Color _c(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  List<GithubRepository> getTrendingRepos() {
    return [
      GithubRepository(
        id: 'r1', name: 'flutter', fullName: 'flutter/flutter',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        owner: 'flutter', ownerAvatar: 'F', language: 'Dart', languageColor: _c('#00B4AB'),
        stars: 165000, forks: 27500, openIssues: 13200, watchers: 4500,
        createdAt: '2015-03-06', updatedAt: '2026-07-20', license: 'BSD-3',
        isFork: false, isArchived: false, topics: ['flutter', 'dart', 'mobile', 'ui', 'cross-platform'],
        commitActivity: _genCommitActivity(55),
        goodFirstIssues: _genIssues(8),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Dart', percent: 75, color: _c('#00B4AB')),
          LanguagePercent(name: 'C++', percent: 15, color: _c('#F34B7D')),
          LanguagePercent(name: 'Java', percent: 10, color: _c('#B07219')),
        ]),
      ),
      GithubRepository(
        id: 'r2', name: 'rust', fullName: 'rust-lang/rust',
        description: 'Empowering everyone to build reliable and efficient software.',
        owner: 'rust-lang', ownerAvatar: 'R', language: 'Rust', languageColor: _c('#DEA584'),
        stars: 101000, forks: 13200, openIssues: 10500, watchers: 3200,
        createdAt: '2010-06-16', updatedAt: '2026-07-21', license: 'MIT/Apache-2.0',
        isFork: false, isArchived: false, topics: ['rust', 'programming-language', 'systems'],
        commitActivity: _genCommitActivity(48),
        goodFirstIssues: _genIssues(12),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Rust', percent: 95, color: _c('#DEA584')),
          LanguagePercent(name: 'Shell', percent: 5, color: _c('#89E051')),
        ]),
      ),
      GithubRepository(
        id: 'r3', name: 'next.js', fullName: 'vercel/next.js',
        description: 'The React Framework for the Web.',
        owner: 'vercel', ownerAvatar: 'V', language: 'JavaScript', languageColor: _c('#F1E05A'),
        stars: 130000, forks: 27800, openIssues: 3200, watchers: 2100,
        createdAt: '2016-10-25', updatedAt: '2026-07-20', license: 'MIT',
        isFork: false, isArchived: false, topics: ['nextjs', 'react', 'javascript', 'ssr', 'web'],
        commitActivity: _genCommitActivity(62),
        goodFirstIssues: _genIssues(5),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'JavaScript', percent: 55, color: _c('#F1E05A')),
          LanguagePercent(name: 'TypeScript', percent: 35, color: _c('#3178C6')),
          LanguagePercent(name: 'MDX', percent: 10, color: _c('#FCB32C')),
        ]),
      ),
      GithubRepository(
        id: 'r4', name: 'langchain', fullName: 'langchain-ai/langchain',
        description: 'Build context-aware reasoning applications.',
        owner: 'langchain-ai', ownerAvatar: 'L', language: 'Python', languageColor: _c('#3572A5'),
        stars: 102000, forks: 16400, openIssues: 890, watchers: 1800,
        createdAt: '2022-10-25', updatedAt: '2026-07-20', license: 'MIT',
        isFork: false, isArchived: false, topics: ['langchain', 'ai', 'llm', 'python', 'rag'],
        commitActivity: _genCommitActivity(70),
        goodFirstIssues: _genIssues(15),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Python', percent: 88, color: _c('#3572A5')),
          LanguagePercent(name: 'TypeScript', percent: 12, color: _c('#3178C6')),
        ]),
      ),
      GithubRepository(
        id: 'r5', name: 'ollama', fullName: 'ollama/ollama',
        description: 'Get up and running with Llama 3, Mistral, Gemma 2, and other large language models.',
        owner: 'ollama', ownerAvatar: 'O', language: 'Go', languageColor: _c('#00ADD8'),
        stars: 118000, forks: 8900, openIssues: 450, watchers: 1500,
        createdAt: '2023-09-08', updatedAt: '2026-07-21', license: 'MIT',
        isFork: false, isArchived: false, topics: ['llm', 'ai', 'go', 'local-ai'],
        commitActivity: _genCommitActivity(65),
        goodFirstIssues: _genIssues(3),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Go', percent: 82, color: _c('#00ADD8')),
          LanguagePercent(name: 'Python', percent: 12, color: _c('#3572A5')),
          LanguagePercent(name: 'Shell', percent: 6, color: _c('#89E051')),
        ]),
      ),
      GithubRepository(
        id: 'r6', name: 'tauri', fullName: 'tauri-apps/tauri',
        description: 'Build smaller, faster, and more secure desktop and mobile applications.',
        owner: 'tauri-apps', ownerAvatar: 'T', language: 'Rust', languageColor: _c('#DEA584'),
        stars: 88000, forks: 2600, openIssues: 890, watchers: 900,
        createdAt: '2019-04-20', updatedAt: '2026-07-20', license: 'MIT/Apache-2.0',
        isFork: false, isArchived: false, topics: ['tauri', 'desktop', 'rust', 'webview'],
        commitActivity: _genCommitActivity(45),
        goodFirstIssues: _genIssues(10),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Rust', percent: 70, color: _c('#DEA584')),
          LanguagePercent(name: 'TypeScript', percent: 20, color: _c('#3178C6')),
          LanguagePercent(name: 'HTML', percent: 10, color: _c('#E34C26')),
        ]),
      ),
      GithubRepository(
        id: 'r7', name: 'shadcn-ui', fullName: 'shadcn-ui/ui',
        description: 'Beautifully designed components built with Radix UI and Tailwind CSS.',
        owner: 'shadcn-ui', ownerAvatar: 'S', language: 'TypeScript', languageColor: _c('#3178C6'),
        stars: 82000, forks: 5200, openIssues: 320, watchers: 800,
        createdAt: '2023-01-15', updatedAt: '2026-07-20', license: 'MIT',
        isFork: false, isArchived: false, topics: ['react', 'components', 'tailwind', 'ui'],
        commitActivity: _genCommitActivity(58),
        goodFirstIssues: _genIssues(4),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'TypeScript', percent: 65, color: _c('#3178C6')),
          LanguagePercent(name: 'CSS', percent: 25, color: _c('#563D7C')),
          LanguagePercent(name: 'JavaScript', percent: 10, color: _c('#F1E05A')),
        ]),
      ),
      GithubRepository(
        id: 'r8', name: 'expo', fullName: 'expo/expo',
        description: 'An open-source platform for making universal native apps.',
        owner: 'expo', ownerAvatar: 'E', language: 'TypeScript', languageColor: _c('#3178C6'),
        stars: 38000, forks: 5800, openIssues: 1200, watchers: 700,
        createdAt: '2015-03-10', updatedAt: '2026-07-20', license: 'MIT',
        isFork: false, isArchived: false, topics: ['react-native', 'expo', 'mobile', 'javascript'],
        commitActivity: _genCommitActivity(68),
        goodFirstIssues: _genIssues(7),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'TypeScript', percent: 60, color: _c('#3178C6')),
          LanguagePercent(name: 'JavaScript', percent: 25, color: _c('#F1E05A')),
          LanguagePercent(name: 'Objective-C', percent: 15, color: _c('#438EFF')),
        ]),
      ),
      GithubRepository(
        id: 'r9', name: 'bun', fullName: 'oven-sh/bun',
        description: 'Incredibly fast JavaScript runtime, bundler, test runner, and package manager.',
        owner: 'oven-sh', ownerAvatar: 'B', language: 'Zig', languageColor: _c('#EC915C'),
        stars: 76000, forks: 2800, openIssues: 680, watchers: 600,
        createdAt: '2022-07-01', updatedAt: '2026-07-21', license: 'MIT',
        isFork: false, isArchived: false, topics: ['bun', 'javascript', 'runtime', 'bundler'],
        commitActivity: _genCommitActivity(52),
        goodFirstIssues: _genIssues(6),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Zig', percent: 55, color: _c('#EC915C')),
          LanguagePercent(name: 'C', percent: 30, color: _c('#555555')),
          LanguagePercent(name: 'JavaScript', percent: 15, color: _c('#F1E05A')),
        ]),
      ),
      GithubRepository(
        id: 'r10', name: 'vite', fullName: 'vitejs/vite',
        description: 'Next generation frontend tooling.',
        owner: 'vitejs', ownerAvatar: 'V', language: 'TypeScript', languageColor: _c('#3178C6'),
        stars: 70000, forks: 6300, openIssues: 420, watchers: 550,
        createdAt: '2020-09-28', updatedAt: '2026-07-20', license: 'MIT',
        isFork: false, isArchived: false, topics: ['vite', 'bundler', 'frontend', 'devtools'],
        commitActivity: _genCommitActivity(60),
        goodFirstIssues: _genIssues(9),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'TypeScript', percent: 85, color: _c('#3178C6')),
          LanguagePercent(name: 'JavaScript', percent: 10, color: _c('#F1E05A')),
          LanguagePercent(name: 'CSS', percent: 5, color: _c('#563D7C')),
        ]),
      ),
      GithubRepository(
        id: 'r11', name: 'supabase', fullName: 'supabase/supabase',
        description: 'The open source Firebase alternative.',
        owner: 'supabase', ownerAvatar: 'S', language: 'TypeScript', languageColor: _c('#3178C6'),
        stars: 75000, forks: 7100, openIssues: 680, watchers: 500,
        createdAt: '2019-10-01', updatedAt: '2026-07-20', license: 'Apache-2.0',
        isFork: false, isArchived: false, topics: ['supabase', 'firebase', 'postgres', 'backend'],
        commitActivity: _genCommitActivity(56),
        goodFirstIssues: _genIssues(11),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'TypeScript', percent: 70, color: _c('#3178C6')),
          LanguagePercent(name: 'Dart', percent: 15, color: _c('#00B4AB')),
          LanguagePercent(name: 'SQL', percent: 15, color: _c('#E38C00')),
        ]),
      ),
      GithubRepository(
        id: 'r12', name: 'zig', fullName: 'ziglang/zig',
        description: 'General-purpose programming language and toolchain for maintaining robust software.',
        owner: 'ziglang', ownerAvatar: 'Z', language: 'Zig', languageColor: _c('#EC915C'),
        stars: 38000, forks: 2400, openIssues: 1800, watchers: 400,
        createdAt: '2016-02-08', updatedAt: '2026-07-21', license: 'MIT',
        isFork: false, isArchived: false, topics: ['zig', 'programming-language', 'compiler'],
        commitActivity: _genCommitActivity(42),
        goodFirstIssues: _genIssues(20),
        languageDistribution: LanguageDistribution(languages: [
          LanguagePercent(name: 'Zig', percent: 90, color: _c('#EC915C')),
          LanguagePercent(name: 'C', percent: 10, color: _c('#555555')),
        ]),
      ),
    ];
  }

  List<GithubDeveloper> getTrendingDevelopers() {
    final repos = getTrendingRepos();
    return [
      GithubDeveloper(
        id: 'd1', username: 'torvalds', displayName: 'Linus Torvalds',
        avatar: 'L', bio: 'Creator of Linux and Git', company: 'Linux Foundation',
        location: 'Portland, OR', website: 'https://torvalds.org',
        followers: 210000, following: 0, publicRepos: 7, contributions: 15234,
        popularRepos: repos.sublist(0, 2), topLanguages: ['C', 'Assembly', 'Shell'],
        isSponsored: false,
        contributionGraph: _genContributions(),
      ),
      GithubDeveloper(
        id: 'd2', username: 'gaearon', displayName: 'Dan Abramov',
        avatar: 'D', bio: 'Working on something new. Co-author of Redux and React docs.',
        company: 'Meta', location: 'London, UK',
        followers: 105000, following: 1700, publicRepos: 850, contributions: 8900,
        popularRepos: repos.sublist(2, 4), topLanguages: ['JavaScript', 'TypeScript', 'MDX'],
        isSponsored: true,
        contributionGraph: _genContributions(),
      ),
      GithubDeveloper(
        id: 'd3', username: 'sindresorhus', displayName: 'Sindre Sorhus',
        avatar: 'S', bio: 'Indie open-source developer. Creator of many popular npm packages.',
        location: 'Oslo, Norway', website: 'https://sindresorhus.com',
        followers: 62000, following: 190, publicRepos: 1200, contributions: 22000,
        popularRepos: repos.sublist(4, 6), topLanguages: ['JavaScript', 'Swift', 'TypeScript'],
        isSponsored: false,
        contributionGraph: _genContributions(),
      ),
      GithubDeveloper(
        id: 'd4', username: 'ThePrimeagen', displayName: 'ThePrimeagen',
        avatar: 'T', bio: 'Senior Staff Software Engineer. I type Vim motions btw.',
        company: 'Netflix', location: 'Nashville, TN',
        followers: 48000, following: 250, publicRepos: 120, contributions: 4500,
        popularRepos: repos.sublist(6, 8), topLanguages: ['TypeScript', 'Lua', 'Rust'],
        isSponsored: true,
        contributionGraph: _genContributions(),
      ),
      GithubDeveloper(
        id: 'd5', username: 'EvanYou', displayName: 'Evan You',
        avatar: 'E', bio: 'Creator of Vue.js and Vite. Building the future of frontend tooling.',
        company: 'Vue.js', location: 'Shanghai, China',
        followers: 78000, following: 320, publicRepos: 340, contributions: 11000,
        popularRepos: repos.sublist(8, 10), topLanguages: ['TypeScript', 'JavaScript', 'Go'],
        isSponsored: true,
        contributionGraph: _genContributions(),
      ),
      GithubDeveloper(
        id: 'd6', username: 'fabpot', displayName: 'Fabien Potencier',
        avatar: 'F', bio: 'Created Symfony, Twig, SwiftMailer. CEO of SensioLabs.',
        company: 'SensioLabs', location: 'Paris, France',
        followers: 26000, following: 520, publicRepos: 280, contributions: 18000,
        popularRepos: repos.sublist(10, 12), topLanguages: ['PHP', 'JavaScript', 'Shell'],
        isSponsored: false,
        contributionGraph: _genContributions(),
      ),
    ];
  }

  List<CommitActivity> _genCommitActivity(int avg) {
    final now = DateTime.now();
    return List.generate(12, (i) {
      final week = now.subtract(Duration(days: (11 - i) * 7));
      final base = avg + (i * 2);
      return CommitActivity(
        week: '${week.month}/${week.day}',
        total: base + (i % 3) * 10,
        daily: List.generate(7, (d) => (base / 7).round() + (d % 2 == 0 ? 3 : -2)),
      );
    });
  }

  List<Issue> _genIssues(int count) {
    final titles = [
      'Add dark mode support for mobile layout',
      'Performance regression on large datasets',
      'TypeScript strict mode compatibility',
      'Update CI/CD pipeline to latest actions',
      'Document migration guide for v3.0',
      'Fix memory leak in WebSocket handler',
      'Add RTL language support',
      'Improve error messages for invalid inputs',
      'Support custom themes and plugins',
      'Add unit tests for core modules',
      'Keyboard navigation not working in modals',
      'Console warning in production builds',
      'E2E tests failing on Safari',
      'Bundle size increased after refactor',
      'Accessibility improvements for screen readers',
    ];
    final labels = ['good first issue', 'bug', 'enhancement', 'documentation', 'help wanted'];
    return List.generate(count, (i) => Issue(
      id: 'i$i', title: titles[i % titles.length], number: '#${1000 + i}',
      body: 'Description of the issue...', state: 'open',
      createdAt: '2026-07-${(10 + i).toString().padLeft(2, '0')}',
      labels: [labels[i % labels.length]],
      author: 'contributor${i + 1}', comments: (i * 3) % 25,
    ));
  }

  List<ContributionDay> _genContributions() {
    final now = DateTime.now();
    return List.generate(52 * 7, (i) {
      final day = now.subtract(Duration(days: 364 - i));
      final isWeekend = day.weekday > 5;
      final count = isWeekend ? (i % 5) : (i % 7) + 1;
      return ContributionDay(date: '${day.month}/${day.day}', count: count);
    });
  }

  List<GithubRepository> searchRepos(String query) {
    if (query.isEmpty) return getTrendingRepos();
    final q = query.toLowerCase();
    return getTrendingRepos().where((r) =>
        r.name.toLowerCase().contains(q) ||
        r.fullName.toLowerCase().contains(q) ||
        r.description.toLowerCase().contains(q) ||
        r.language.toLowerCase().contains(q) ||
        r.topics.any((t) => t.contains(q))).toList();
  }
}

import '../../domain/entities/skill_analyzer_entities.dart';

class SkillAnalyzerLocalDataSource {
  SkillAnalysis analyzeFromSources(List<ImportSource> sources) {
    final allSkills = _getAllSkills(sources);
    final categories = _buildCategories(allSkills);
    final overallScore = _calculateOverallScore(categories);

    return SkillAnalysis(
      overallScore: overallScore,
      categories: categories,
      atsResult: _getATSResult(sources),
      missingSkills: _getMissingSkills(allSkills),
      courseRecommendations: _getCourseRecommendations(allSkills),
      careerSuggestions: _getCareerSuggestions(allSkills),
      salaryEstimate: _getSalaryEstimate(),
      learningPlan: _getLearningPlan(),
      sources: sources,
    );
  }

  List<Skill> _getAllSkills(List<ImportSource> sources) {
    final skills = <Skill>[];

    skills.addAll([
      Skill(name: 'Dart', category: SkillCategoryType.mobile, level: SkillLevel.advanced, proficiency: 85, yearsOfExperience: 3),
      Skill(name: 'Flutter', category: SkillCategoryType.mobile, level: SkillLevel.advanced, proficiency: 82, yearsOfExperience: 2),
      Skill(name: 'React Native', category: SkillCategoryType.mobile, level: SkillLevel.intermediate, proficiency: 55, yearsOfExperience: 1),
      Skill(name: 'Swift', category: SkillCategoryType.mobile, level: SkillLevel.beginner, proficiency: 25, yearsOfExperience: 0),
      Skill(name: 'JavaScript', category: SkillCategoryType.frontend, level: SkillLevel.advanced, proficiency: 80, yearsOfExperience: 3),
      Skill(name: 'TypeScript', category: SkillCategoryType.frontend, level: SkillLevel.intermediate, proficiency: 65, yearsOfExperience: 1),
      Skill(name: 'HTML/CSS', category: SkillCategoryType.frontend, level: SkillLevel.expert, proficiency: 90, yearsOfExperience: 4),
      Skill(name: 'React', category: SkillCategoryType.frontend, level: SkillLevel.intermediate, proficiency: 60, yearsOfExperience: 1),
      Skill(name: 'Next.js', category: SkillCategoryType.frontend, level: SkillLevel.beginner, proficiency: 35, yearsOfExperience: 0),
      Skill(name: 'Python', category: SkillCategoryType.backend, level: SkillLevel.intermediate, proficiency: 62, yearsOfExperience: 1),
      Skill(name: 'Node.js', category: SkillCategoryType.backend, level: SkillLevel.intermediate, proficiency: 58, yearsOfExperience: 1),
      Skill(name: 'Django', category: SkillCategoryType.backend, level: SkillLevel.beginner, proficiency: 30, yearsOfExperience: 0),
      Skill(name: 'PostgreSQL', category: SkillCategoryType.backend, level: SkillLevel.intermediate, proficiency: 55, yearsOfExperience: 1),
      Skill(name: 'Firebase', category: SkillCategoryType.backend, level: SkillLevel.advanced, proficiency: 75, yearsOfExperience: 2),
      Skill(name: 'Docker', category: SkillCategoryType.devops, level: SkillLevel.beginner, proficiency: 35, yearsOfExperience: 0),
      Skill(name: 'AWS', category: SkillCategoryType.devops, level: SkillLevel.beginner, proficiency: 30, yearsOfExperience: 0),
      Skill(name: 'Git', category: SkillCategoryType.devops, level: SkillLevel.advanced, proficiency: 80, yearsOfExperience: 3),
      Skill(name: 'CI/CD', category: SkillCategoryType.devops, level: SkillLevel.beginner, proficiency: 40, yearsOfExperience: 0),
      Skill(name: 'Figma', category: SkillCategoryType.design, level: SkillLevel.intermediate, proficiency: 50, yearsOfExperience: 1),
      Skill(name: 'UI/UX Design', category: SkillCategoryType.design, level: SkillLevel.intermediate, proficiency: 55, yearsOfExperience: 1),
      Skill(name: 'Communication', category: SkillCategoryType.softSkills, level: SkillLevel.advanced, proficiency: 78, yearsOfExperience: 0),
      Skill(name: 'Team Leadership', category: SkillCategoryType.softSkills, level: SkillLevel.intermediate, proficiency: 60, yearsOfExperience: 0),
      Skill(name: 'Problem Solving', category: SkillCategoryType.softSkills, level: SkillLevel.advanced, proficiency: 82, yearsOfExperience: 0),
    ]);

    if (sources.contains(ImportSource.github)) {
      skills.addAll([
        Skill(name: 'GraphQL', category: SkillCategoryType.backend, level: SkillLevel.beginner, proficiency: 25, yearsOfExperience: 0),
        Skill(name: 'Redis', category: SkillCategoryType.backend, level: SkillLevel.beginner, proficiency: 20, yearsOfExperience: 0),
      ]);
    }

    if (sources.contains(ImportSource.linkedin)) {
      skills.addAll([
        Skill(name: 'Agile/Scrum', category: SkillCategoryType.softSkills, level: SkillLevel.intermediate, proficiency: 55, yearsOfExperience: 1),
        Skill(name: 'Technical Writing', category: SkillCategoryType.softSkills, level: SkillLevel.beginner, proficiency: 35, yearsOfExperience: 0),
      ]);
    }

    return skills;
  }

  List<SkillCategory> _buildCategories(List<Skill> skills) {
    final grouped = <SkillCategoryType, List<Skill>>{};
    for (final skill in skills) {
      grouped.putIfAbsent(skill.category, () => []).add(skill);
    }

    return grouped.entries.map((entry) {
      final avg = entry.value.fold<double>(0, (sum, s) => sum + s.proficiency) / entry.value.length;
      return SkillCategory(type: entry.key, skills: entry.value, averageProficiency: avg);
    }).toList();
  }

  int _calculateOverallScore(List<SkillCategory> categories) {
    if (categories.isEmpty) return 0;
    final total = categories.fold<double>(0, (sum, c) => sum + c.averageProficiency);
    return (total / categories.length).round();
  }

  ATSResult _getATSResult(List<ImportSource> sources) {
    return ATSResult(
      score: 72,
      breakdown: {
        'Keywords': 80,
        'Formatting': 85,
        'Experience': 65,
        'Education': 75,
        'Skills Match': 70,
      },
      suggestions: [
        'Add more industry-specific keywords to your resume',
        'Include quantifiable achievements (numbers, percentages)',
        'Use standard section headers (Experience, Education, Skills)',
        'Add a professional summary at the top',
        'Ensure consistent date formatting throughout',
      ],
      keywordsFound: [
        'Flutter', 'Dart', 'Firebase', 'Git', 'JavaScript',
        'REST API', 'Agile', 'CI/CD', 'State Management',
      ],
      keywordsMissing: [
        'Microservices', 'Kubernetes', 'Terraform', 'Redis',
        'GraphQL', 'System Design', 'Tech Lead', 'Mentoring',
      ],
    );
  }

  List<MissingSkill> _getMissingSkills(List<Skill> skills) {
    return const [
      MissingSkill(
        name: 'System Design',
        category: SkillCategoryType.backend,
        importance: 'High',
        reason: 'Essential for senior roles and technical interviews',
      ),
      MissingSkill(
        name: 'Kubernetes',
        category: SkillCategoryType.devops,
        importance: 'High',
        reason: 'Industry standard for container orchestration',
      ),
      MissingSkill(
        name: 'GraphQL',
        category: SkillCategoryType.backend,
        importance: 'Medium',
        reason: 'Growing adoption in modern API development',
      ),
      MissingSkill(
        name: 'Testing (Unit/Integration)',
        category: SkillCategoryType.mobile,
        importance: 'High',
        reason: 'Critical for production-quality applications',
      ),
      MissingSkill(
        name: 'Performance Optimization',
        category: SkillCategoryType.mobile,
        importance: 'Medium',
        reason: 'Key differentiator for experienced developers',
      ),
      MissingSkill(
        name: 'Terraform/IaC',
        category: SkillCategoryType.devops,
        importance: 'Medium',
        reason: 'Infrastructure as Code is increasingly important',
      ),
    ];
  }

  List<CourseRecommendation> _getCourseRecommendations(List<Skill> skills) {
    return const [
      CourseRecommendation(
        title: 'System Design Interview Preparation',
        provider: 'Coursera',
        skillTarget: 'System Design',
        rating: 4.8,
        duration: '6 weeks',
        difficulty: 'Advanced',
        url: 'https://coursera.org/system-design',
      ),
      CourseRecommendation(
        title: 'Kubernetes for Beginners',
        provider: 'Udemy',
        skillTarget: 'Kubernetes',
        rating: 4.6,
        duration: '4 weeks',
        difficulty: 'Intermediate',
        url: 'https://udemy.com/kubernetes',
      ),
      CourseRecommendation(
        title: 'GraphQL with Flutter',
        provider: 'YouTube (FreeCodeCamp)',
        skillTarget: 'GraphQL',
        rating: 4.5,
        duration: '2 weeks',
        difficulty: 'Intermediate',
        url: 'https://youtube.com/graphql-flutter',
      ),
      CourseRecommendation(
        title: 'Flutter Testing Masterclass',
        provider: 'Udemy',
        skillTarget: 'Testing',
        rating: 4.7,
        duration: '3 weeks',
        difficulty: 'Intermediate',
        url: 'https://udemy.com/flutter-testing',
      ),
      CourseRecommendation(
        title: 'AWS Certified Cloud Practitioner',
        provider: 'AWS',
        skillTarget: 'AWS',
        rating: 4.8,
        duration: '8 weeks',
        difficulty: 'Beginner',
        url: 'https://aws.amazon.com/certification',
      ),
    ];
  }

  List<CareerSuggestion> _getCareerSuggestions(List<Skill> skills) {
    return const [
      CareerSuggestion(
        title: 'Senior Flutter Developer',
        matchPercentage: 88,
        requiredSkills: ['Flutter', 'Dart', 'State Management', 'Testing', 'CI/CD'],
        yourMatchingSkills: ['Flutter', 'Dart', 'Firebase', 'Git'],
        salaryRange: '\$110K - \$150K',
        growthRate: '+25% YoY',
        description: 'Lead mobile app development with Flutter. Build cross-platform applications.',
      ),
      CareerSuggestion(
        title: 'Full-Stack Developer',
        matchPercentage: 72,
        requiredSkills: ['React/Next.js', 'Node.js', 'PostgreSQL', 'TypeScript', 'Docker'],
        yourMatchingSkills: ['JavaScript', 'TypeScript', 'Node.js', 'PostgreSQL'],
        salaryRange: '\$95K - \$135K',
        growthRate: '+15% YoY',
        description: 'Build end-to-end web applications with modern JavaScript frameworks.',
      ),
      CareerSuggestion(
        title: 'Mobile App Architect',
        matchPercentage: 65,
        requiredSkills: ['Flutter', 'System Design', 'CI/CD', 'Team Leadership', 'Performance Optimization'],
        yourMatchingSkills: ['Flutter', 'Dart', 'Firebase', 'Communication'],
        salaryRange: '\$130K - \$175K',
        growthRate: '+20% YoY',
        description: 'Design and oversee mobile application architecture and technical strategy.',
      ),
      CareerSuggestion(
        title: 'DevOps Engineer',
        matchPercentage: 45,
        requiredSkills: ['AWS', 'Kubernetes', 'Docker', 'Terraform', 'CI/CD', 'Monitoring'],
        yourMatchingSkills: ['Docker', 'Git', 'CI/CD'],
        salaryRange: '\$105K - \$145K',
        growthRate: '+22% YoY',
        description: 'Manage cloud infrastructure, CI/CD pipelines, and deployment automation.',
      ),
    ];
  }

  SalaryEstimate _getSalaryEstimate() {
    return const SalaryEstimate(
      role: 'Senior Mobile Developer',
      minSalary: 100000,
      maxSalary: 155000,
      medianSalary: 125000,
      location: 'Remote (US)',
      experienceLevel: '3-5 years',
    );
  }

  LearningPlan _getLearningPlan() {
    return const LearningPlan(
      title: 'Senior Developer Roadmap',
      totalDuration: '12 weeks',
      targetRole: 'Senior Flutter Developer',
      steps: [
        LearningStep(
          title: 'System Design Fundamentals',
          description: 'Learn distributed systems, load balancing, caching, and database design patterns.',
          duration: '3 weeks',
          resources: ['System Design Interview (Alex Xu)', 'Grokking System Design', 'YouTube: System Design'],
          isCompleted: false,
          skills: ['System Design', 'Architecture'],
        ),
        LearningStep(
          title: 'Testing & Quality',
          description: 'Master unit, widget, and integration testing in Flutter.',
          duration: '2 weeks',
          resources: ['Flutter Testing Docs', 'Udemy: Flutter Testing', 'Mockito Package'],
          isCompleted: false,
          skills: ['Unit Testing', 'Widget Testing', 'Integration Testing'],
        ),
        LearningStep(
          title: 'CI/CD & DevOps',
          description: 'Set up automated pipelines with GitHub Actions and Fastlane.',
          duration: '2 weeks',
          resources: ['GitHub Actions Docs', 'Fastlane Docs', 'Codemagic'],
          isCompleted: false,
          skills: ['CI/CD', 'Fastlane', 'GitHub Actions'],
        ),
        LearningStep(
          title: 'Cloud & Backend',
          description: 'Deepen Firebase knowledge and explore AWS basics.',
          duration: '3 weeks',
          resources: ['Firebase Advanced Course', 'AWS Cloud Practitioner', 'Firestore Security Rules'],
          isCompleted: false,
          skills: ['Firebase', 'AWS', 'Cloud Architecture'],
        ),
        LearningStep(
          title: 'Portfolio & Interview Prep',
          description: 'Build showcase projects and practice technical interviews.',
          duration: '2 weeks',
          resources: ['LeetCode Medium/Hard', 'Pramp Mock Interviews', 'GitHub Portfolio'],
          isCompleted: false,
          skills: ['Problem Solving', 'Communication', 'Team Leadership'],
        ),
      ],
    );
  }
}

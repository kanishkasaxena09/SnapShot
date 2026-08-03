import '../../domain/entities/ai_assistant_entities.dart';

class AIAssistantLocalDataSource {
                                   
  AIAssistantLocalDataSource() {
    _conversationCounter = 3;
    _conversations.addAll([
      Conversation(
        id: 'conv-1',
        title: 'Flutter State Management',
        messages: [
          ChatMessage(
            id: 'msg-1-1',
            role: MessageRole.user,
            content: 'What is the best state management approach for Flutter?',
            timestamp: DateTime(0),
          ),
          ChatMessage(
            id: 'msg-1-2',
            role: MessageRole.assistant,
            content: '''## State Management in Flutter

There are several excellent approaches, each with different strengths:

### 1. **Riverpod** (Recommended)
- Compile-time safe
- No context dependency
- Excellent testability
- Supports multiple providers

### 2. **BLoC/Cubit**
- Event-driven architecture
- Great for complex business logic
- Well-structured separation of concerns

### 3. **GetX**
- Simple and lightweight
- Built-in navigation and dependency injection
- Quick to set up

### 4. **Provider**
- Official recommended approach
- Simple to learn
- Good for small to medium apps

```dart
// Riverpod example
final counterProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('\$count');
  }
}
```

For your project, I'd recommend **Riverpod** as it provides the best balance of simplicity and power.''',
            timestamp: DateTime(0),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Conversation(
        id: 'conv-2',
        title: 'Career Path in AI/ML',
        messages: [
          ChatMessage(
            id: 'msg-2-1',
            role: MessageRole.user,
            content: 'How should I start my career in AI/ML?',
            timestamp: DateTime(0),
          ),
          ChatMessage(
            id: 'msg-2-2',
            role: MessageRole.assistant,
            content: '''## Starting Your AI/ML Career

### 📚 Foundation Skills
1. **Mathematics**: Linear Algebra, Calculus, Probability & Statistics
2. **Programming**: Python (primary), R, SQL
3. **Data Skills**: Data manipulation, visualization, analysis

### 🎯 Learning Path
1. **Week 1-4**: Python basics + NumPy/Pandas
2. **Week 5-8**: Machine Learning fundamentals (Scikit-learn)
3. **Week 9-12**: Deep Learning (TensorFlow/PyTorch)
4. **Week 13-16**: Specialization (NLP, Computer Vision, or RL)

### 💼 Portfolio Projects
- Image classifier
- Sentiment analysis tool
- Recommendation system
- Time series forecasting

### 📖 Resources
- Fast.ai (free courses)
- Andrew Ng's ML Specialization
- Kaggle competitions
- Papers With Code

### 🚀 Next Steps
Start with a small project that interests you. Learning by building is the most effective approach.''',
            timestamp: DateTime(0),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ]);
  }
  final List<Conversation> _conversations = [];
  int _conversationCounter = 0;

  List<Conversation> getConversations() => List.unmodifiable(_conversations);

  Conversation? getConversation(String id) {
    final matches = _conversations.where((c) => c.id == id);
    return matches.isNotEmpty ? matches.first : null;
  }

  Conversation createConversation({
    String title = 'New Chat',
    AIAssistantMode mode = AIAssistantMode.general,
  }) {
    _conversationCounter++;
    final conversation = Conversation(
      id: 'conv-$_conversationCounter',
      title: title,
      messages: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mode: mode,
    );
    _conversations.insert(0, conversation);
    return conversation;
  }

  void deleteConversation(String id) {
    _conversations.removeWhere((c) => c.id == id);
  }

  void updateConversation(Conversation conversation) {
    final index = _conversations.indexWhere((c) => c.id == conversation.id);
    if (index != -1) {
      _conversations[index] = conversation;
    }
  }

  String generateAIResponse(String userMessage, AIAssistantMode mode) {
    final lower = userMessage.toLowerCase();

    if (lower.contains('resume') || mode == AIAssistantMode.resumeAnalysis) {
      return _getResumeAnalysisResponse(userMessage);
    }
    if (lower.contains('github') || lower.contains('repo') || mode == AIAssistantMode.githubAnalysis) {
      return _getGitHubAnalysisResponse(userMessage);
    }
    if (lower.contains('career') || lower.contains('job') || mode == AIAssistantMode.careerGuidance) {
      return _getCareerGuidanceResponse(userMessage);
    }
    if (lower.contains('learn') || lower.contains('roadmap') || lower.contains('study') || mode == AIAssistantMode.learningRoadmap) {
      return _getLearningRoadmapResponse(userMessage);
    }
    if (lower.contains('code') || lower.contains('flutter') || lower.contains('dart')) {
      return _getCodeResponse(userMessage);
    }
    return _getGeneralResponse(userMessage);
  }

  String _getResumeAnalysisResponse(String message) {
    return '''## 📄 Resume Analysis

### Overall Score: **78/100**

### Strengths ✅
- **Strong technical skills section** — Well-organized and relevant
- **Quantified achievements** — Numbers and metrics are present
- **Clear work experience** — Good progression shown

### Areas for Improvement ⚠️

1. **Summary Section**
   - Make it more impactful
   - Focus on your unique value proposition
   - Keep it under 3 lines

2. **Skills Section**
   - Group skills by category
   - Remove outdated technologies
   - Add proficiency levels

3. **Projects**
   - Add links to live demos
   - Include GitHub repositories
   - Describe impact and technologies used

### 📝 Suggested Summary
> "Full-stack developer with 3+ years of experience building scalable mobile and web applications. Passionate about clean architecture and user experience. Proficient in Flutter, React, and cloud technologies."

### 💡 Pro Tips
- Tailor your resume for each application
- Use action verbs (Built, Led, Implemented, Optimized)
- Keep it to 1-2 pages maximum
- Include keywords from the job description''';
  }

  String _getGitHubAnalysisResponse(String message) {
    return '''## 🔍 GitHub Profile Analysis

### Repository Overview
| Metric | Value |
|--------|-------|
| Public Repos | 24 |
| Total Stars | 156 |
| Total Forks | 43 |
| Contributions (last year) | 847 |

### 🏆 Top Repositories

**1. flutter-super-app** ⭐ 45
- Clean architecture Flutter project
- 12 contributors, active development
- Good documentation and CI/CD

**2. ai-chat-api** ⭐ 38
- RESTful API with Python/FastAPI
- Comprehensive test coverage (92%)

**3. devops-toolkit** ⭐ 28
- Docker & Kubernetes configurations
- Well-documented setup guides

### 📊 Activity Heatmap
- Most active on **Weekdays**
- Peak hours: **10 AM - 2 PM**
- Consistent contribution pattern

### 💡 Recommendations
1. **Add more documentation** to smaller repos
2. **Create a portfolio README** showcasing best work
3. **Contribute to open source** projects in your tech stack
4. **Add CI/CD** to repositories missing it
5. **Write blog posts** about your technical projects''';
  }

  String _getCareerGuidanceResponse(String message) {
    return '''## 🚀 Career Guidance

### Current Market Trends (2025)

**High-Demand Roles:**
1. AI/ML Engineer — 45% growth
2. Cloud Architect — 35% growth
3. Full-Stack Developer — 30% growth
4. DevOps Engineer — 28% growth

### 📈 Salary Insights
| Level | Range (USD) |
|-------|-------------|
| Junior (0-2 yrs) | \$60K - \$85K |
| Mid (3-5 yrs) | \$85K - \$130K |
| Senior (5+ yrs) | \$130K - \$180K |
| Lead/Principal | \$180K - \$250K+ |

### 🎯 Action Plan

**Short-term (3 months):**
- Complete 2-3 portfolio projects
- Update LinkedIn and GitHub
- Start networking at tech meetups

**Medium-term (6 months):**
- Contribute to open source
- Write technical blog posts
- Get relevant certifications

**Long-term (12 months):**
- Apply for target roles
- Consider conference speaking
- Build a personal brand

### 💡 Key Skills to Develop
- System Design & Architecture
- Cloud platforms (AWS/GCP/Azure)
- AI/ML integration
- Leadership & communication''';
  }

  String _getLearningRoadmapResponse(String message) {
    return '''## 🗺️ Learning Roadmap

### Personalized 12-Week Plan

#### Phase 1: Foundations (Weeks 1-4)
```
Week 1: Language Basics
  ├── Core syntax and features
  ├── Data structures
  └── OOP concepts

Week 2: Intermediate Concepts
  ├── Async programming
  ├── Error handling
  └── Package management

Week 3: Framework Basics
  ├── Widget tree
  ├── State management
  └── Navigation

Week 4: First Project
  └── Build a complete mini-app
```

#### Phase 2: Advanced (Weeks 5-8)
- Testing (unit, widget, integration)
- Performance optimization
- CI/CD setup
- Advanced state management

#### Phase 3: Specialization (Weeks 9-12)
- Choose your path:
  - 🔹 Mobile (Flutter/React Native)
  - 🔹 Web (Next.js/Nuxt)
  - 🔹 Backend (Node.js/Go)
  - 🔹 AI/ML (Python/TensorFlow)

### 📚 Recommended Resources
1. **Official Documentation** — Always start here
2. **Udemy/Coursera** — Structured courses
3. **YouTube** — Visual learning
4. **Practice** — LeetCode, HackerRank
5. **Projects** — Build real things

### ✅ Milestones
- [ ] Complete basics
- [ ] Build 3 projects
- [ ] Deploy to production
- [ ] Contribute to open source
- [ ] Get certified''';
  }

  String _getCodeResponse(String message) {
    return '''## 💻 Here's the code you requested:

```dart
import 'package:flutter/material.dart';

class SmartCounter extends StatefulWidget {
  const SmartCounter({super.key});

  @override
  State<SmartCounter> createState() => _SmartCounterState();
}

class _SmartCounterState extends State<SmartCounter> {
  int _count = 0;
  
  void _increment() => setState(() => _count++);
  void _decrement() => setState(() => _count--);
  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$_count',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: _decrement,
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FilledButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
            const SizedBox(width: 16),
            FilledButton.tonal(
              onPressed: _increment,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 🔍 Key Points
- Uses `StatefulWidget` for mutable state
- Clean separation of methods
- Follows Flutter best practices
- Material Design 3 compatible

### 🚀 Usage
Simply add this widget to your widget tree:
```dart
const SmartCounter()
```''';
  }

  String _getGeneralResponse(String message) {
    return '''## 💡 Here's what I think

Thank you for your question! Let me break this down for you.

### Key Insights

1. **Context Matters** — The best approach depends on your specific use case, team size, and project requirements.

2. **Start Simple** — Always begin with the simplest solution that works, then optimize as needed.

3. **Best Practices**:
   - Follow established patterns
   - Write clean, readable code
   - Add proper error handling
   - Include documentation

### 🛠️ What You Can Do

| Priority | Action |
|----------|--------|
| High | Define clear requirements |
| Medium | Research existing solutions |
| Low | Plan for scalability |

### 📚 Want to Learn More?

I can help you with:
- **Code examples** — Just ask for specific implementations
- **Architecture advice** — System design and patterns
- **Debugging** — Share your code and error messages
- **Career guidance** — Learning paths and opportunities

Feel free to ask more specific questions! 😊''';
  }
}

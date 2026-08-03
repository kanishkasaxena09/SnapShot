class ApiConstants {
  ApiConstants._();

  // --- Firebase Firestore Collections ---
  static const String usersCollection = 'users';
  static const String resumesCollection = 'resumes';
  static const String bookmarksCollection = 'bookmarks';
  static const String notificationsCollection = 'notifications';
  static const String searchHistoryCollection = 'search_history';
  static const String aiToolsCollection = 'ai_tools';
  static const String projectsCollection = 'projects';

  // --- External APIs ---
  static const String hackerNewsBase = 'https://hacker-news.firebaseio.com/v0';
  static const String devToBase = 'https://dev.to/api';
  static const String githubApiBase = 'https://api.github.com';
  static const String semanticScholarBase = 'https://api.semanticscholar.org/graph/v1';
  static const String arxivBase = 'http://export.arxiv.org/api';
  static const String jsearchBase = 'https://jsearch.p.rapidapi.com';
  static const String openAiBase = 'https://api.openai.com/v1';

  // --- Hacker News ---
  static const String hnTopStories = '$hackerNewsBase/topstories.json';
  static const String hnNewStories = '$hackerNewsBase/newstories.json';
  static const String hnBestStories = '$hackerNewsBase/beststories.json';
  static const String hnItem = '$hackerNewsBase/item';

  // --- Dev.to ---
  static const String devToArticles = '$devToBase/articles';

  // --- GitHub ---
  static const String githubSearchRepos = '$githubApiBase/search/repositories';
  static const String githubTrending = '$githubApiBase/search/repositories';
  static const String githubUser = '$githubApiBase/user';

  // --- Semantic Scholar ---
  static const String s2PaperSearch = '$semanticScholarBase/paper/search';
  static const String s2Paper = '$semanticScholarBase/paper';

  // --- OpenAI ---
  static const String openAiChat = '$openAiBase/chat/completions';
  static const String openAiModels = '$openAiBase/models';

  // --- JSearch (RapidAPI) ---
  static const String jsearchSearch = '$jsearchBase/search';

  // --- Query Parameters ---
  static const String queryParam = 'query';
  static const String pageParam = 'page';
  static const String perPageParam = 'per_page';
  static const String sortParam = 'sort';
  static const String orderParam = 'order';
  static const String limitParam = 'limit';
  static const String offsetParam = 'offset';
  static const String fieldsParam = 'fields';
}

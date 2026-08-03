enum Environment { dev, staging, prod }

class Env {

  const Env._({
    required this.environment,
    required this.baseUrl,
    required this.firebaseApiKey,
    required this.firebaseProjectId,
    required this.openAIApiKey,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.enableLogging,
    required this.enableAnalytics,
  });
  final Environment environment;
  final String baseUrl;
  final String firebaseApiKey;
  final String firebaseProjectId;
  final String openAIApiKey;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool enableLogging;
  final bool enableAnalytics;

  static late Env _instance;

  static Env get instance => _instance;

  static void init(Environment env) {
    switch (env) {
      case Environment.dev:
        _instance = _dev;
      case Environment.staging:
        _instance = _staging;
      case Environment.prod:
        _instance = _prod;
    }
  }

  static const _dev = Env._(
    environment: Environment.dev,
    baseUrl: 'https://api-dev.snapshot.app',
    firebaseApiKey: 'DEV_FIREBASE_API_KEY',
    firebaseProjectId: 'snapshot-dev',
    openAIApiKey: 'DEV_OPENAI_API_KEY',
    supabaseUrl: 'https://jlcsikgonlnfwwlcufex.supabase.co',
    supabaseAnonKey: 'sb_publishable_HZzU1ZnRCGPgBlnQe5lQkg_YNnzuU78',
    enableLogging: true,
    enableAnalytics: false,
  );

  static const _staging = Env._(
    environment: Environment.staging,
    baseUrl: 'https://api-staging.snapshot.app',
    firebaseApiKey: 'STAGING_FIREBASE_API_KEY',
    firebaseProjectId: 'snapshot-staging',
    openAIApiKey: 'STAGING_OPENAI_API_KEY',
    supabaseUrl: 'https://staging.supabase.co',
    supabaseAnonKey: 'STAGING_SUPABASE_ANON_KEY',
    enableLogging: true,
    enableAnalytics: false,
  );

  static const _prod = Env._(
    environment: Environment.prod,
    baseUrl: 'https://api.snapshot.app',
    firebaseApiKey: 'PROD_FIREBASE_API_KEY',
    firebaseProjectId: 'snapshot-prod',
    openAIApiKey: 'PROD_OPENAI_API_KEY',
    supabaseUrl: 'https://prod.supabase.co',
    supabaseAnonKey: 'PROD_SUPABASE_ANON_KEY',
    enableLogging: false,
    enableAnalytics: true,
  );

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}

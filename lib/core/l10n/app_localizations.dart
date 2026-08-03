import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // --- Common ---
  String get appTitle => _localizedValues[locale.languageCode]?['appTitle'] ?? 'Snapshot';
  String get home => _localizedValues[locale.languageCode]?['home'] ?? 'Home';
  String get profile => _localizedValues[locale.languageCode]?['profile'] ?? 'Profile';
  String get search => _localizedValues[locale.languageCode]?['search'] ?? 'Search';
  String get settings => _localizedValues[locale.languageCode]?['settings'] ?? 'Settings';
  String get save => _localizedValues[locale.languageCode]?['save'] ?? 'Save';
  String get cancel => _localizedValues[locale.languageCode]?['cancel'] ?? 'Cancel';
  String get delete => _localizedValues[locale.languageCode]?['delete'] ?? 'Delete';
  String get edit => _localizedValues[locale.languageCode]?['edit'] ?? 'Edit';
  String get loading => _localizedValues[locale.languageCode]?['loading'] ?? 'Loading...';
  String get error => _localizedValues[locale.languageCode]?['error'] ?? 'Error';
  String get retry => _localizedValues[locale.languageCode]?['retry'] ?? 'Retry';
  String get noData => _localizedValues[locale.languageCode]?['noData'] ?? 'No data available';
  String get seeAll => _localizedValues[locale.languageCode]?['seeAll'] ?? 'See All';
  String get viewDetails => _localizedValues[locale.languageCode]?['viewDetails'] ?? 'View Details';

  // --- Profile ---
  String get achievements => _localizedValues[locale.languageCode]?['achievements'] ?? 'Achievements';
  String get bookmarks => _localizedValues[locale.languageCode]?['bookmarks'] ?? 'Bookmarks';
  String get history => _localizedValues[locale.languageCode]?['history'] ?? 'History';
  String get learningStats => _localizedValues[locale.languageCode]?['learningStats'] ?? 'Learning Stats';
  String get githubStats => _localizedValues[locale.languageCode]?['githubStats'] ?? 'GitHub Stats';
  String get resumeScore => _localizedValues[locale.languageCode]?['resumeScore'] ?? 'Resume Score';
  String get themeSettings => _localizedValues[locale.languageCode]?['themeSettings'] ?? 'Theme Settings';
  String get accountSettings => _localizedValues[locale.languageCode]?['accountSettings'] ?? 'Account Settings';
  String get logOut => _localizedValues[locale.languageCode]?['logOut'] ?? 'Log Out';

  // --- Jobs ---
  String get savedJobs => _localizedValues[locale.languageCode]?['savedJobs'] ?? 'Saved Jobs';
  String get applications => _localizedValues[locale.languageCode]?['applications'] ?? 'Applications';
  String get applyNow => _localizedValues[locale.languageCode]?['applyNow'] ?? 'Apply Now';

  // --- Learning ---
  String get courses => _localizedValues[locale.languageCode]?['courses'] ?? 'Courses';
  String get lessons => _localizedValues[locale.languageCode]?['lessons'] ?? 'Lessons';
  String get quizzes => _localizedValues[locale.languageCode]?['quizzes'] ?? 'Quizzes';

  // --- Misc ---
  String get offlineMode => _localizedValues[locale.languageCode]?['offlineMode'] ?? 'You are offline';
  String get pullToRefresh => _localizedValues[locale.languageCode]?['pullToRefresh'] ?? 'Pull to refresh';

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Snapshot',
      'home': 'Home',
      'profile': 'Profile',
      'search': 'Search',
      'settings': 'Settings',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'noData': 'No data available',
      'seeAll': 'See All',
      'viewDetails': 'View Details',
      'achievements': 'Achievements',
      'bookmarks': 'Bookmarks',
      'history': 'History',
      'learningStats': 'Learning Stats',
      'githubStats': 'GitHub Stats',
      'resumeScore': 'Resume Score',
      'themeSettings': 'Theme Settings',
      'accountSettings': 'Account Settings',
      'logOut': 'Log Out',
      'savedJobs': 'Saved Jobs',
      'applications': 'Applications',
      'applyNow': 'Apply Now',
      'courses': 'Courses',
      'lessons': 'Lessons',
      'quizzes': 'Quizzes',
      'offlineMode': 'You are offline',
      'pullToRefresh': 'Pull to refresh',
    },
    'hi': {
      'appTitle': 'स्नैपशॉट',
      'home': 'होम',
      'profile': 'प्रोफ़ाइल',
      'search': 'खोजें',
      'settings': 'सेटिंग्स',
      'save': 'सहेजें',
      'cancel': 'रद्द करें',
      'delete': 'हटाएं',
      'edit': 'संपादित करें',
      'loading': 'लोड हो रहा है...',
      'error': 'त्रुटि',
      'retry': 'पुनः प्रयास करें',
      'noData': 'कोई डेटा उपलब्ध नहीं',
      'seeAll': 'सभी देखें',
      'viewDetails': 'विवरण देखें',
      'achievements': 'उपलब्धियां',
      'bookmarks': 'बुकमार्क',
      'history': 'इतिहास',
      'learningStats': 'लर्निंग स्टैट्स',
      'githubStats': 'गिटहब स्टैट्स',
      'resumeScore': 'रिज़्यूमे स्कोर',
      'themeSettings': 'थीम सेटिंग्स',
      'accountSettings': 'खाता सेटिंग्स',
      'logOut': 'लॉग आउट',
      'savedJobs': 'सहेजी नौकरियां',
      'applications': 'आवेदन',
      'applyNow': 'अभी आवेदन करें',
      'courses': 'पाठ्यक्रम',
      'lessons': 'पाठ',
      'quizzes': 'प्रश्नोत्तरी',
      'offlineMode': 'आप ऑफलाइन हैं',
      'pullToRefresh': 'रीफ्रेश के लिए खींचें',
    },
    'es': {
      'appTitle': 'Snapshot',
      'home': 'Inicio',
      'profile': 'Perfil',
      'search': 'Buscar',
      'settings': 'Ajustes',
      'save': 'Guardar',
      'cancel': 'Cancelar',
      'delete': 'Eliminar',
      'edit': 'Editar',
      'loading': 'Cargando...',
      'error': 'Error',
      'retry': 'Reintentar',
      'noData': 'No hay datos disponibles',
      'seeAll': 'Ver todo',
      'viewDetails': 'Ver detalles',
      'achievements': 'Logros',
      'bookmarks': 'Marcadores',
      'history': 'Historial',
      'learningStats': 'Estadísticas',
      'githubStats': 'GitHub Stats',
      'resumeScore': 'Puntuación CV',
      'themeSettings': 'Tema',
      'accountSettings': 'Cuenta',
      'logOut': 'Cerrar sesión',
      'savedJobs': 'Trabajos guardados',
      'applications': 'Aplicaciones',
      'applyNow': 'Aplicar ahora',
      'courses': 'Cursos',
      'lessons': 'Lecciones',
      'quizzes': 'Cuestionarios',
      'offlineMode': 'Estás sin conexión',
      'pullToRefresh': 'Desliza para actualizar',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

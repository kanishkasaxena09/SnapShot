import 'package:dio/dio.dart';

import '../../config/env.dart';
import '../constants/api_constants.dart';
import 'dio_interceptors.dart';

class ApiClient {

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.instance.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(),
      if (Env.instance.enableLogging) LoggingInterceptor(),
      RetryInterceptor(dio: _dio),
    ]);
  }
  late final Dio _dio;

  Dio get dio => _dio;

  /// Creates a standalone Dio instance for external APIs
  /// (not using the app's base URL or interceptors).
  Dio createExternalClient({
    required String baseUrl,
    Map<String, dynamic>? headers,
  }) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    );
  }

  /// Pre-configured client for GitHub API.
  Dio get githubClient => createExternalClient(
        baseUrl: ApiConstants.githubApiBase,
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

  /// Pre-configured client for Hacker News API.
  Dio get hackerNewsClient => createExternalClient(
        baseUrl: ApiConstants.hackerNewsBase,
      );

  /// Pre-configured client for Dev.to API.
  Dio get devToClient => createExternalClient(
        baseUrl: ApiConstants.devToBase,
      );

  /// Pre-configured client for Semantic Scholar API.
  Dio get semanticScholarClient => createExternalClient(
        baseUrl: ApiConstants.semanticScholarBase,
      );

  /// Pre-configured client for OpenAI API.
  Dio get openAIClient => createExternalClient(
        baseUrl: ApiConstants.openAiBase,
        headers: {'Authorization': 'Bearer ${Env.instance.openAIApiKey}'},
      );
}

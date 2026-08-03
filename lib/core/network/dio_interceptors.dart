import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: 'auth_token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            '${ApiConstants.usersCollection}/refresh',
            data: {'refresh_token': refreshToken},
          );
          final newToken = response.data['access_token'] as String?;
          final newRefresh = response.data['refresh_token'] as String?;

          if (newToken != null) {
            await _storage.write(key: 'auth_token', value: newToken);
            if (newRefresh != null) {
              await _storage.write(key: 'refresh_token', value: newRefresh);
            }

            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final dio = Dio();
            final retryResponse = await dio.fetch(err.requestOptions);
            handler.resolve(retryResponse);
            return;
          }
        } catch (_) {
          await _storage.delete(key: 'auth_token');
          await _storage.delete(key: 'refresh_token');
        }
      }
    }
    handler.next(err);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print('[HTTP] ${options.method} ${options.uri}');
    if (options.data != null) {
      print('[BODY] ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    print('[HTTP] ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[ERROR] ${err.type} ${err.requestOptions.uri}');
    print('[ERROR MSG] ${err.message}');
    handler.next(err);
  }
}

class RetryInterceptor extends Interceptor {

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
  });
  final Dio dio;
  final int maxRetries;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      final delay = Duration(seconds: retryCount + 1);
      await Future<void>.delayed(delay);

      err.requestOptions.extra['retryCount'] = retryCount + 1;

      try {
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (_) {}
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.response?.statusCode != null &&
            err.response!.statusCode! >= 500);
  }
}

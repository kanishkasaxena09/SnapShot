import 'package:freezed_annotation/freezed_annotation.dart';

import 'exceptions.dart';

part 'failures.freezed.dart';

/// Unified failure class representing all possible error states
/// for the UI layer. Created from [AppException] via [Failure.fromException].
@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.connection({
    String? message,
  }) = ConnectionFailure;

  const factory Failure.timeout({
    String? message,
  }) = TimeoutFailure;

  const factory Failure.cache({
    String? message,
  }) = CacheFailure;

  const factory Failure.auth({
    required String message,
    int? statusCode,
  }) = AuthFailure;

  const factory Failure.parsing({
    String? message,
  }) = ParsingFailure;

  const factory Failure.validation({
    String? message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  const factory Failure.file({
    String? message,
  }) = FileFailure;

  const factory Failure.permission({
    String? message,
  }) = PermissionFailure;

  const factory Failure.unknown({
    String? message,
  }) = UnknownFailure;

  /// Create a [Failure] from any [AppException].
  factory Failure.fromException(AppException exception) {
    return switch (exception) {
      final ServerException e => Failure.server(
          message: e.message,
          statusCode: e.statusCode,
        ),
      final ConnectionException e => Failure.connection(message: e.message),
      final TimeoutException e => Failure.timeout(message: e.message),
      final CacheException e => Failure.cache(message: e.message),
      final AuthException e => Failure.auth(
          message: e.message,
          statusCode: e.statusCode,
        ),
      final ParsingException e => Failure.parsing(message: e.message),
      final ValidationException e => Failure.validation(
          message: e.message,
          fieldErrors: e.fieldErrors,
        ),
      final FileException e => Failure.file(message: e.message),
      final PermissionException e => Failure.permission(message: e.message),
    };
  }
}

/// Extension for user-friendly error messages.
extension FailureExtension on Failure {
  String get displayMessage => when(
        server: (message, _) => message,
        connection: (message) => message ?? 'No internet connection.',
        timeout: (message) => message ?? 'Request timed out.',
        cache: (message) => message ?? 'Local storage error.',
        auth: (message, _) => message,
        parsing: (message) => message ?? 'Data parsing error.',
        validation: (message, _) => message ?? 'Validation failed.',
        file: (message) => message ?? 'File operation failed.',
        permission: (message) => message ?? 'Permission denied.',
        unknown: (message) => message ?? 'An unexpected error occurred.',
      );
}

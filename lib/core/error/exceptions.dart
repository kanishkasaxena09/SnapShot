/// Base class for all app exceptions.
/// Maps to user-facing [Failure] objects.
sealed class AppException implements Exception {

  const AppException({
    required this.message,
    this.statusCode,
    this.originalError,
  });
  final String message;
  final int? statusCode;
  final dynamic originalError;

  @override
  String toString() => 'AppException: $message (statusCode: $statusCode)';
}

/// Thrown when a network request fails.
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Thrown when there is no internet connection.
class ConnectionException extends AppException {
  const ConnectionException({
    super.message = 'No internet connection. Please check your network.',
    super.originalError,
  });
}

/// Thrown when a request times out.
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out. Please try again.',
    super.originalError,
  });
}

/// Thrown when local storage operations fail.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Failed to access local storage.',
    super.originalError,
  });
}

/// Thrown when authentication fails.
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Thrown when data parsing/serialization fails.
class ParsingException extends AppException {
  const ParsingException({
    super.message = 'Failed to parse response data.',
    super.originalError,
  });
}

/// Thrown when a user input validation fails.
class ValidationException extends AppException {

  const ValidationException({
    super.message = 'Validation failed.',
    this.fieldErrors,
    super.originalError,
  });
  final Map<String, String>? fieldErrors;
}

/// Thrown when a file operation fails.
class FileException extends AppException {
  const FileException({
    super.message = 'File operation failed.',
    super.originalError,
  });
}

/// Thrown when a permission is denied.
class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Permission denied.',
    super.originalError,
  });
}

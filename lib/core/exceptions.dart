class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(super.message);
}

class BookingException extends AppException {
  BookingException(super.message);
}

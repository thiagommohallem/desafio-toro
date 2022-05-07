abstract class AuthException implements Exception {
  String message;
  AuthException({
    required this.message,
  });
}

class UserNotFoundException extends AuthException {
  UserNotFoundException({required String message}) : super(message: message);
}

class IncorrectPasswordException extends AuthException {
  IncorrectPasswordException({required String message})
      : super(message: message);
}

class BannedUserException extends AuthException {
  BannedUserException({required String message}) : super(message: message);
}

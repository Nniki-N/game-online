import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();
}

@immutable
class LogInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class LogInWithGoogleAuthEvent extends AuthEvent {
  const LogInWithGoogleAuthEvent();
}

@immutable
class LogInAnonymouslyAuthEvent extends AuthEvent {
  const LogInAnonymouslyAuthEvent();
}

@immutable
class LogOutAuthEvent extends AuthEvent {
  const LogOutAuthEvent();
}

@immutable
class RegisterAuthEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String login;

  const RegisterAuthEvent({
    required this.email,
    required this.password,
    required this.username,
    required this.login,
  });
}

@immutable
class RegisterAnonymousUserAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterAnonymousUserAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class DeleteAccountAuthEvent extends AuthEvent {
  const DeleteAccountAuthEvent();
}

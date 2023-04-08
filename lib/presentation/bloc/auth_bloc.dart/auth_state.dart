import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/errors/auth_error.dart';

@immutable
abstract class AuthState {
  final AuthError? error;

  const AuthState({
    this.error,
  });
}

@immutable
class LoadingAuthState extends AuthState {
  const LoadingAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}

@immutable
class LoggedInAuthState extends AuthState {
  const LoggedInAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}

@immutable
class LoggedOutAuthState extends AuthState {
  const LoggedOutAuthState({
    AuthError? error,
  }) : super(
          error: error,
        );
}

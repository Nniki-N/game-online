import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/account.dart';
import 'package:game/common/errors/auth_error.dart';

@immutable
abstract class AuthRepository {
  const AuthRepository();

  /// Logs the user in the app with email and password.
  ///
  /// Returns [Account] if a login process is successful.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<Account?> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Logs the user in the app via Gogle Authentication.
  ///
  /// Returns [Account] if a login process is successful.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<Account?> logInWithGoogle();

  /// Logs the user in the app anonymously.
  ///
  /// Returns [Account] if a login process is successful.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<Account?> logInAnonymously();

  /// Logs the user out from the app.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<void> logOut();

  /// Registers the user with email, password, username and login.
  ///
  /// Returns [Account] if a register process is successful.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<Account?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String login,
  });

  /// Registers an anonymous user with email and password.
  ///
  /// Returns [Account] if a register process is successful.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Deletes the user account.
  /// 
  /// Throws [AuthError] when the error occurs.
  Future<void> deleteAccount();

  /// Checks if the user is logged in.
  Future<bool> isLoggedIn();

  /// Checks if the user is logged in anonymously.
  Future<void> isAnonymousUser();
}

import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/account.dart';

@immutable
abstract class AuthRepository {
  const AuthRepository();

  Future<Account?> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Account?> logInWithGoogle();

  Future<Account?> logInAnonymously();

  Future<void> logOut();

  Future<Account?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String login,
  });

  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> deleteAccount();

  Future<bool> isLoggedIn();
}

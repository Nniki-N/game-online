import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';

@immutable
abstract class AuthenticationRepository {
  const AuthenticationRepository();

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
  });

  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required AccountModel accountModel,
    required String email,
    required String password,
  });

  Future<void> deleteAccount();

  Future<bool> isLoggedIn();
}

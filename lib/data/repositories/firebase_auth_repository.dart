import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/data/datasources/firebase_auth_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/auth_repository.dart';

@immutable
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource _authDatasource;

  const FirebaseAuthRepository({
    required FirebaseAuthDataSource authDatasource,
  }) : _authDatasource = authDatasource;

  /// Logs the user in the app with email and password.
  /// 
  /// Returns [Account] if login process is successful and null if not.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AccountModel? accountModel =
          await _authDatasource.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _returnAccountEntity(accountModel: accountModel);
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Logs the user in the app via Gogle Authentication.
  /// 
  /// Returns [Account] if login process is successful and null if not.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthErrorUnknown] when the error of type [PlatformException] occurs.
  @override
  Future<Account?> logInWithGoogle() async {
    try {
      final AccountModel? accountModel =
          await _authDatasource.logInWithGoogle();

      return _returnAccountEntity(accountModel: accountModel);
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on PlatformException {
      throw const AuthErrorUnknown();
    }
  }

  /// Logs the user in the app anonymously.
  /// 
  /// Returns [Account] if login process is successful and null if not.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInAnonymously() async {
    try {
      final AccountModel? accountModel =
          await _authDatasource.logInAnonymously();

      return _returnAccountEntity(accountModel: accountModel);
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Logs the user out from the app.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthErrorUnknown] when the error of type [PlatformException] occurs.
  @override
  Future<void> logOut() async {
    try {
      await _authDatasource.logOut();
    } on PlatformException {
      throw const AuthErrorUnknown();
    }
  }

  /// Registers user with email, password, username and login.
  /// 
  /// Returns [Account] if register process is successful and null if not.
  ///
  /// Throws [AuthErrorLoginIsAlreadyUsed] if specific login is already used
  /// by someone.
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String login,
  }) async {
    try {
      // checks if specific login is already used by someone
      if (await _authDatasource.loginIsAlreadyUsed(login: login)) {
        throw const AuthErrorLoginIsAlreadyUsed();
      }

      final AccountModel? accountModel =
          await _authDatasource.registerWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
        login: login,
      );

      return _returnAccountEntity(accountModel: accountModel);
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on AuthError {
      rethrow;
    }
  }

  /// Registers anonymous user with email and password.
  /// 
  /// Returns [Account] if register process is successful and null if not.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AccountModel? newAccountModel = await _authDatasource
          .registerAnonymousUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _returnAccountEntity(accountModel: newAccountModel);
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Deletes user account.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<void> deleteAccount() async {
    try {
      await _authDatasource.deleteAccount();
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on AuthError {
      rethrow;
    }
  }

  /// Checks if user is logged in.
  @override
  Future<bool> isLoggedIn() async => _authDatasource.isLoggedIn();

  /// Converts [AccountModel] in [Account].
  Account? _returnAccountEntity({required AccountModel? accountModel}) {
    if (accountModel != null) {
      return Account.fromAccountModel(accountModel: accountModel);
    } else {
      return null;
    }
  }
}

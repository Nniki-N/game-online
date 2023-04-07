import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/data/datasources/firebase_authentication_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/authentication_repository.dart';

@immutable
class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuthenticationDataSource _authenticationDatasource;

  const FirebaseAuthenticationRepository({
    required FirebaseAuthenticationDataSource authenticationDatasource,
  }) : _authenticationDatasource = authenticationDatasource;

  /// Logs the user in the app with email and password.
  ///
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AccountModel? accountModel =
          await _authenticationDatasource.logInWithEmailAndPassword(
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
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthErrorUnknown] when the error of type [PlatformException] occurs.
  @override
  Future<Account?> logInWithGoogle() async {
    try {
      final AccountModel? accountModel =
          await _authenticationDatasource.logInWithGoogle();

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
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInAnonymously() async {
    try {
      final AccountModel? accountModel =
          await _authenticationDatasource.logInAnonymously();

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
      await _authenticationDatasource.logOut();
    } on PlatformException {
      throw const AuthErrorUnknown();
    }
  }

  /// Registers user with email and password.
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
      if (await _authenticationDatasource.loginIsAlreadyUsed(login: login)) {
        throw const AuthErrorLoginIsAlreadyUsed();
      }

      final AccountModel? accountModel =
          await _authenticationDatasource.registerWithEmailAndPassword(
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
  /// Throws [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required AccountModel accountModel,
    required String email,
    required String password,
  }) async {
    try {
      final AccountModel? newAccountModel = await _authenticationDatasource
          .registerAnonymousUserWithEmailAndPassword(
        accountModel: accountModel,
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
      await _authenticationDatasource.deleteAccount();
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
  Future<bool> isLoggedIn() async => _authenticationDatasource.isLoggedIn();

  /// Converts [AccountModel] in [Account].
  Account? _returnAccountEntity({required AccountModel? accountModel}) {
    if (accountModel != null) {
      return Account.fromAccountModel(accountModel: accountModel);
    } else {
      return null;
    }
  }
}

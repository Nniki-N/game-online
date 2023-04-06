import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/errors/auth_error.dart';
import 'package:game/data/datasources/authentication_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/authentication_repository.dart';

@immutable
class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final AuthenticationDataSource _firestoreDatasource;

  const FirebaseAuthenticationRepository({
    required AuthenticationDataSource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

  /// Logs the user in the app via Firebase Authentication with email and password.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firestoreDatasource.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Logs user in the app via Google Authentication and Firebase Authentication
  /// with credentials.
  ///
  /// Creates and account the first time  user signs in with Google.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthError] when the error of type [PlatformException] occurs.
  @override
  Future<Account?> logInWithGoogle() async {
    //
  }

  /// Creates account and logs user in the app anonymously.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> logInAnonymously() async {
    //
  }

  /// Logs the user out from the app.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthError] when the error of type [PlatformException] occurs.
  @override
  Future<void> logOut() async {
    //
  }

  /// Registers userr with email and password and creates account.
  ///
  /// Throws [AuthError] if specific login is already used by someone.
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    //
  }

  /// Links anonymous user with email and password.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<Account?> registerAnonymousUserWithEmailAndPassword({
    required AccountModel accountModel,
    required String email,
    required String password,
  }) async {
    //
  }

  /// Delete account from Firebase Authentication and Firestore Database.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  @override
  Future<void> deleteAccount() async {
    //
  }

  /// Checks if user is logged in.
  @override
  Future<bool> isLoggedIn() async {
    return false;
  }
}

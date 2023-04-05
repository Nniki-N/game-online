import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/datasources/firestore_datasource.dart';
import 'package:game/domain/repositories/authorize_repository.dart';

@immutable
class AuthorizeRepositoryImp extends AuthorizeRepository {
  final FirestoreDatasource firestoreDatasource;

  const AuthorizeRepositoryImp({
    required this.firestoreDatasource,
  });

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    //
  }

  Future<void> logInWithLoginAndPassword({
    required String login,
    required String password,
  }) async {
    //
  }

  Future<void> logInWithGoogleAccount() async {
    //
  }

  Future<void> logInAnonymously() async {
    //
  }

  Future<void> logOut() async {
    //
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    //
  }

  Future<bool> isLoggedIn() async {
    return false;
  }
}

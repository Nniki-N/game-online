import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:game/data/models/account_model.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class FirebaseAccountDatasource {
  final FirebaseAccountDatasourceHelper _firebaseAccountDatasourceHelper;
  final FirebaseAuth _firebaseAuth;

  FirebaseAccountDatasource({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseAccountDatasourceHelper =
            FirebaseAccountDatasourceHelper.instance(
          firebaseFirestore: firebaseFirestore,
          logger: logger,
        );

  /// Retrieves an account data of the current user from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Throws [AccountErrorRetrievingAccount] if a [User] retrieving from local
  /// Firebase Database failed.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<AccountModel> getCurrentAccountModel() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user == null) throw const AccountErrorRetrievingAccount();

      final AccountModel accountModel =
          await _firebaseAccountDatasourceHelper.getAccountModel(
        uid: user.uid,
      );

      return accountModel;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a user account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<AccountModel> getAccountModel({required String uid}) async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountDatasourceHelper.getAccountModel(
        uid: uid,
      );

      return accountModel;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a stream of changes of an account data of a current user from
  /// the Firestore Database and returns a stream of [AccountModel] if the request was successful.
  ///
  /// Throws [AccountErrorRetrievingAccount] if a [User] retrieving from local
  /// Firebase Database failed.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Stream<AccountModel> getCurrentAccountModelStream() {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user == null) throw const AccountErrorRetrievingAccount();

      final Stream<AccountModel> accountModelStream =
          _firebaseAccountDatasourceHelper.getAccountModelStream(uid: user.uid);

      return accountModelStream;
    } catch (exception) {
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<void> updateAccount({required AccountModel accountModel}) async {
    try {
      log('notificationsUidList inside account datasource: ${accountModel.notificationsUidList}');

      await _firebaseAccountDatasourceHelper.updateAccount(
        accountModel: accountModel,
      );

      log('updated inside datasource');
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a list of users where [fieldName] equals [fieldValue] from the
  /// Firestore Database and returns a list of [AccountModel] if the request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  Future<List<AccountModel>> getAccountModelListWhere({
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    try {
      final List<AccountModel> accountModelsList =
          await _firebaseAccountDatasourceHelper.getAccountModelListWhere(
        fieldName: fieldName,
        fieldValue: fieldValue,
      );

      return accountModelsList;
    } catch (exception) {
      rethrow;
    }
  }
}

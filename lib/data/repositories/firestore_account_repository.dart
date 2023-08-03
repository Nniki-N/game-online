import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/datasources/firebase_account_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/domain/repositories/account_repository.dart';

@immutable
class FirestoreAccountRepository implements AccountRepository {
  final FirebaseAccountDatasource _firebaseAccountDatasource;

  const FirestoreAccountRepository({
    required FirebaseAccountDatasource firebaseAccountDatasource,
  }) : _firebaseAccountDatasource = firebaseAccountDatasource;

  /// Retrieves an account data of the current user from the Firestore Database
  /// and returns [Account] if request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<Account> getCurrentAccount() async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();

      final Account account = Account.fromAccountModel(
        accountModel: accountModel,
      );

      return account;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves an account data of the current user from the Firestore Database
  /// and returns [UserAccount] if request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<UserAccount> getCurrentUserAccount() async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();

      final UserAccount account = UserAccount.fromAccountModel(
        accountModel: accountModel,
      );

      return account;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves an user account data from the Firestore Database
  /// and returns [UserAccount] if request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<UserAccount> getUserAccount({required String uid}) async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountDatasource.getAccountModel(uid: uid);

      final UserAccount account = UserAccount.fromAccountModel(
        accountModel: accountModel,
      );

      return account;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a stream of changes of a account data of the current user from
  /// the Firestore Database and returns a stream of [UserAccount] if the request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Stream<UserAccount> getCurrentUserAccountStream() {
    try {
      final Stream<AccountModel> accountModelStream =
          _firebaseAccountDatasource.getCurrentAccountModelStream();

      final Stream<UserAccount> userAccountStream = accountModelStream.map(
        (accountModel) =>
            UserAccount.fromAccountModel(accountModel: accountModel),
      );

      return userAccountStream;
    } catch (exception) {
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<void> updateUserAccount({required UserAccount userAccount}) async {
    try {
      final AccountModel accountModel = AccountModel.fromUserAccountEntity(
        userAccount: userAccount,
      );

      await _firebaseAccountDatasource.updateAccount(
          accountModel: accountModel);
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a list of users where [fieldName] equals [fieldValue] from the Firestore Database
  /// and returns a list of [UserAccount] if the request was successful.
  ///
  /// Rethrows [AccountError] when the error occurs.
  @override
  Future<List<UserAccount>> getUserAccountListWhere({
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    try {
      final List<AccountModel> accountModelsList =
          await _firebaseAccountDatasource.getAccountModelListWhere(
        fieldName: fieldName,
        fieldValue: fieldValue,
      );

      final List<UserAccount> userAccountsList = accountModelsList.map(
        (accountModel) {
          return UserAccount.fromAccountModel(accountModel: accountModel);
        },
      ).toList();

      return userAccountsList;
    } catch (exception) {
      rethrow;
    }
  }
}

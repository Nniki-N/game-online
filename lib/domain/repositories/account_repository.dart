import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/account.dart';

@immutable
abstract class AccountRepository {
  const AccountRepository();

  /// Retrieves an account data of the current user and returns [Account] if request was successful.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Future<Account> getCurrentAccount();

  /// Retrieves an account data of the current user and returns [UserAccount] if request was successful.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Future<UserAccount> getCurrentUserAccount();

  /// Retrieves a user account data and returns [UserAccount] if request was successful.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Future<UserAccount> getUserAccount({required String uid});

  /// Retrieves a stream of changes of an account data of a current user
  /// and returns a stream of [UserAccount] if the request was successful.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Stream<UserAccount> getCurrentUserAccountStream();

  /// Updates a user account data.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Future<void> updateUserAccount({required UserAccount userAccount});

  /// Retrieves a list of users where [fieldName] equals [fieldValue] 
  /// and returns a list of [UserAccount] if the request was successful.
  /// 
  /// Rethrows [AccountError] when the error occurs.
  Future<List<UserAccount>> getAccountModelListWhere({
    required String fieldName,
    required dynamic fieldValue,
  });
}

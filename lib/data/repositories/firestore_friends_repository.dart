import 'package:flutter/foundation.dart';
import 'package:game/common/errors/friends_error.dart';
import 'package:game/data/datasources/firebase_account_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/friends_repository.dart';
import 'package:logger/logger.dart';

@immutable
class FirestoreFriendsRepository extends FriendsRepository {
  final FirebaseAccountDatasource _firebaseAccountDatasource;
  final Logger _logger;

  const FirestoreFriendsRepository({
    required FirebaseAccountDatasource firebaseAccountDatasource,
    required Logger logger,
  })  : _firebaseAccountDatasource = firebaseAccountDatasource,
        _logger = logger;

  /// Retrieves a list of friends of a current user from the Firebase Firestore.
  ///
  /// Throws [FriendsErrorRetrievingFriendsList] when the error occurs.
  @override
  Future<List<Account>> getFriendsList() async {
    try {
      // Retrieves a current user account model.
      final AccountModel currentAccountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();

      // A list of friends of a current user.
      final List<String> friendsUidList = currentAccountModel.friendsUidList;

      // Retrieves future account models of friends of a current user.
      final List<Future<AccountModel>> friendsFutureAccountModels =
          friendsUidList.map((uid) {
        final accountModel =
            _firebaseAccountDatasource.getAccountModel(uid: uid);

        return accountModel;
      }).toList();

      List<Account> accountsList = [];

      // Converts account models to accounts.
      await Future.forEach(
        friendsFutureAccountModels,
        (futureAccountModel) async {
          final AccountModel accountModel = await futureAccountModel;

          final Account account = Account.fromAccountModel(
            accountModel: accountModel,
          );

          accountsList.add(account);
        },
      );

      return accountsList;
    } catch (exeption) {
      _logger.e(exeption);
      throw const FriendsErrorRetrievingFriendsList();
    }
  }

  /// Adds a friend uid to the user account friends list in the Firebase Firestore.
  ///
  /// Throws [FriendsErrorThisUserIsAlreadyFriend] if specified friend uid is
  /// already in the friends list.
  ///
  /// Throws [FriendsErrorFriendAdding] when any other error occurs.
  @override
  Future<void> addFriend({
    required String uid,
    required String friendUid,
  }) async {
    try {
      // Retrieves a user account model.
      AccountModel accountModel =
          await _firebaseAccountDatasource.getAccountModel(uid: uid);

      // A list of friends of a current user.
      List<String> friendsUidList = accountModel.friendsUidList;

      // Returns if current user already has this user as a friend.
      if (friendsUidList.contains(friendUid)) {
        throw const FriendsErrorThisUserIsAlreadyFriend();
      }

      // Adds friend to the friends list.
      friendsUidList.add(friendUid);

      // Updates a current user model.
      accountModel = accountModel.copyWith(
        friendsUidList: friendsUidList,
      );

      // Updates a current user model in the Firebase Firestore.
      await _firebaseAccountDatasource.updateAccount(
        accountModel: accountModel,
      );
    } on FriendsError catch (friendsError) {
      _logger.e(friendsError);
      rethrow;
    } catch (exeption) {
      _logger.e(exeption);
      throw const FriendsErrorFriendAdding();
    }
  }

  /// Removes a friend uid from the user account friends list in the Firebase Firestore.
  ///
  /// Throws [FriendsErrorFriendRemoving] when the error occurs.
  @override
  Future<void> removeFriend({
    required String uid,
    required String friendUid,
  }) async {
    try {
      // Retrieves a user account model.
      AccountModel accountModel =
          await _firebaseAccountDatasource.getAccountModel(uid: uid);

      // Updated list of friends of a current user.
      List<String> friendsUidList = accountModel.friendsUidList;
      friendsUidList.remove(friendUid);

      // Updates a current user model.
      accountModel = accountModel.copyWith(
        friendsUidList: friendsUidList,
      );

      // Updates a current user model in the Firebase Firestore.
      await _firebaseAccountDatasource.updateAccount(
        accountModel: accountModel,
      );
    } catch (exeption) {
      _logger.e(exeption);
      throw const FriendsErrorFriendRemoving();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/common/errors/friends_error.dart';

@immutable
abstract class FriendsRepository {
  const FriendsRepository();

  /// Retrieves a list of friends of a current user.
  ///
  /// Throws [FriendsErrorRetrievingFriendsList] when the error occurs.
  Future<List<Account>> getFriendsList();

  /// Adds a friend uid to the user account friends list.
  ///
  /// Throws [FriendsErrorThisUserIsAlreadyFriend] if specified friend uid is
  /// already in the friends list.
  ///
  /// Throws [FriendsErrorFriendAdding] when any other error occurs.
  Future<void> addFriend({
    required String uid,
    required String friendUid,
  });

  /// Removes a friend uid from the user account friends list.
  ///
  /// Throws [FriendsErrorFriendRemoving] when the error occurs.
  Future<void> removeFriend({
    required String uid,
    required String friendUid,
  });
}

import 'package:flutter/foundation.dart';

@immutable
abstract class FriendsEvent {
  const FriendsEvent();
}

@immutable
class InitializeFriendsEvent extends FriendsEvent {
  const InitializeFriendsEvent();
}

@immutable
class AddFriendsEvent extends FriendsEvent {
  // final String uid;
  final String friendLogin;

  const AddFriendsEvent({
    // required this.uid,
    required this.friendLogin,
  });
}

@immutable
class RemoveFriendsEvent extends FriendsEvent {
  // final String uid;
  final String friendUid;

  const RemoveFriendsEvent({
    // required this.uid,
    required this.friendUid,
  });
}

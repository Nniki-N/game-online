import 'package:flutter/foundation.dart';
import 'package:game/common/errors/friends_error.dart';
import 'package:game/domain/entities/account.dart';

@immutable
abstract class FriendsState {
  final List<Account> friendsList;

  const FriendsState({
    required this.friendsList,
  });
}

@immutable
class InitialFriendsState extends FriendsState {
  const InitialFriendsState() : super(friendsList: const []);
}

@immutable
class LoadedFriendsState extends FriendsState {
  const LoadedFriendsState({
    required List<Account> friendsList,
  }) : super(friendsList: friendsList);
}

@immutable
class ErrorFriendsState extends FriendsState {
  final FriendsError friendsError;

  const ErrorFriendsState({
    required this.friendsError,
    required List<Account> friendsList,
  }) : super(friendsList: friendsList);
}

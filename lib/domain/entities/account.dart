import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/account_model.dart';

/// This entity is only used to dislplay data about friends or random player.
/// This entity cannot be converted from [AccountModel] model.
@immutable
class Account {
  final String username;
  final String uid;
  final String? avatarLink;
  final bool isActiv;
  final bool isInGame;
  final int gamesCount;
  final int victoriesCount;

  const Account({
    required this.username,
    required this.uid,
    required this.avatarLink,
    required this.isActiv,
    required this.isInGame,
    required this.gamesCount,
    required this.victoriesCount,
  });

  factory Account.fromAccountModel({required AccountModel accountModel}) =>
      Account(
        username: accountModel.username,
        uid: accountModel.uid,
        avatarLink: accountModel.avatarLink,
        isActiv: accountModel.isActiv,
        isInGame: accountModel.isInGame,
        gamesCount: accountModel.gamesCount,
        victoriesCount: accountModel.victoriesCount,
      );
}

/// The [Account] child entity is used to display and change user data.
/// This entity can be converted from [AccountModel] model.
@immutable
class UserAccount extends Account {
  final String login;
  final Iterable<String> friendsUidList;
  final Iterable<String> notificationsUidList;

  const UserAccount({
    required String username,
    required String uid,
    required String? avatarLink,
    required bool isActiv,
    required bool isInGame,
    required int gamesCount,
    required int victoriesCount,
    required this.login,
    required this.friendsUidList,
    required this.notificationsUidList,
  }) : super(
          username: username,
          uid: uid,
          avatarLink: avatarLink,
          isActiv: isActiv,
          isInGame: isInGame,
          gamesCount: gamesCount,
          victoriesCount: victoriesCount,
        );

  factory UserAccount.fromAccountModel({required AccountModel accountModel}) =>
      UserAccount(
        username: accountModel.username,
        login: accountModel.login,
        uid: accountModel.uid,
        avatarLink: accountModel.avatarLink,
        isActiv: accountModel.isActiv,
        isInGame: accountModel.isInGame,
        gamesCount: accountModel.gamesCount,
        victoriesCount: accountModel.victoriesCount,
        friendsUidList: accountModel.friendsUidList,
        notificationsUidList: accountModel.notificationsUidList,
      );
}

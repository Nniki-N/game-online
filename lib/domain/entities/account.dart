// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:game/data/models/account_model.dart';

/// This entity is only used to dislplay data about user, friends or random player.
/// This entity cannot be converted from [AccountModel] model.
class Account {
  final String username;
  final String uid;
  final String? avatarLink;
  final bool isActiv;
  final bool isInGame;
  final String inGameRoomId;
  final int gamesCount;
  final int victoriesCount;

  const Account({
    required this.username,
    required this.uid,
    required this.avatarLink,
    required this.isActiv,
    required this.isInGame,
    required this.inGameRoomId,
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
        inGameRoomId: accountModel.inGameRoomId,
        gamesCount: accountModel.gamesCount,
        victoriesCount: accountModel.victoriesCount,
      );

  Account copyWith({
    String? username,
    String? uid,
    String? avatarLink,
    bool? isActiv,
    bool? isInGame,
    String? inGameRoomId,
    int? gamesCount,
    int? victoriesCount,
  }) {
    return Account(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      avatarLink: avatarLink ?? this.avatarLink,
      isActiv: isActiv ?? this.isActiv,
      isInGame: isInGame ?? this.isInGame,
      inGameRoomId: inGameRoomId ?? this.inGameRoomId,
      gamesCount: gamesCount ?? this.gamesCount,
      victoriesCount: victoriesCount ?? this.victoriesCount,
    );
  }
}

/// The [Account] child entity is used to display and change user data.
/// This entity can be converted from [AccountModel] model.
class UserAccount extends Account {
  final String login;
  final List<String> friendsUidList;
  final List<String> notificationsUidList;

  const UserAccount({
    required String username,
    required String uid,
    required String? avatarLink,
    required bool isActiv,
    required bool isInGame,
    required String inGameRoomId,
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
          inGameRoomId: inGameRoomId,
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
        inGameRoomId: accountModel.inGameRoomId,
        gamesCount: accountModel.gamesCount,
        victoriesCount: accountModel.victoriesCount,
        friendsUidList: accountModel.friendsUidList,
        notificationsUidList: accountModel.notificationsUidList,
      );

  @override
  UserAccount copyWith({
    String? username,
    String? uid,
    String? avatarLink,
    bool? isActiv,
    bool? isInGame,
    String? inGameRoomId,
    int? gamesCount,
    int? victoriesCount,
    String? login,
    List<String>? friendsUidList,
    List<String>? notificationsUidList,
  }) {
    return UserAccount(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      avatarLink: avatarLink ?? this.avatarLink,
      isActiv: isActiv ?? this.isActiv,
      isInGame: isInGame ?? this.isInGame,
      inGameRoomId: inGameRoomId ?? this.inGameRoomId,
      gamesCount: gamesCount ?? this.gamesCount,
      victoriesCount: victoriesCount ?? this.victoriesCount,
      login: login ?? this.login,
      friendsUidList: friendsUidList ?? this.friendsUidList,
      notificationsUidList: notificationsUidList ?? this.notificationsUidList,
    );
  }
}

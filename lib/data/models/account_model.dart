// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:game/domain/entities/account.dart';

part 'account_model.g.dart';

/// This model contains all account data.
/// All accounts are stored in Firebase.
/// This model can be converted from [UserAccount] entity.
@immutable
@JsonSerializable(explicitToJson: true)
class AccountModel {
  @JsonKey(name: AccountSchema.username)
  final String username;
  @JsonKey(name: AccountSchema.login)
  final String login;
  @JsonKey(name: AccountSchema.uid)
  final String uid;
  @JsonKey(name: AccountSchema.avatarLink)
  final String? avatarLink;
  @JsonKey(name: AccountSchema.isActiv)
  final bool isActiv;
  @JsonKey(name: AccountSchema.isInGame)
  final bool isInGame;
  @JsonKey(name: AccountSchema.gamesCount)
  final int gamesCount;
  @JsonKey(name: AccountSchema.victoriesCount)
  final int victoriesCount;
  @JsonKey(name: AccountSchema.friendsUidList)
  final Iterable<String> friendsUidList;
  @JsonKey(name: AccountSchema.notificationsUidList)
  final Iterable<String> notificationsUidList;

  const AccountModel({
    required this.username,
    required this.login,
    required this.uid,
    required this.avatarLink,
    required this.isActiv,
    required this.isInGame,
    required this.gamesCount,
    required this.victoriesCount,
    required this.friendsUidList,
    required this.notificationsUidList,
  });

  factory AccountModel.fromJson(Json json) => _$AccountModelFromJson(json);
  Json toJson() => _$AccountModelToJson(this);

  factory AccountModel.fromUserAccountEntity({
    required UserAccount userAccount,
  }) =>
      AccountModel(
        username: userAccount.username,
        uid: userAccount.uid,
        login: userAccount.login,
        avatarLink: userAccount.avatarLink,
        isActiv: userAccount.isActiv,
        isInGame: userAccount.isInGame,
        gamesCount: userAccount.gamesCount,
        victoriesCount: userAccount.victoriesCount,
        friendsUidList: userAccount.friendsUidList,
        notificationsUidList: userAccount.notificationsUidList,
      );

  AccountModel copyWith({
    String? username,
    String? login,
    String? uid,
    String? avatarLink,
    bool? isActiv,
    bool? isInGame,
    int? gamesCount,
    int? victoriesCount,
    Iterable<String>? friendsUidList,
    Iterable<String>? notificationsUidList,
  }) {
    return AccountModel(
      username: username ?? this.username,
      login: login ?? this.login,
      uid: uid ?? this.uid,
      avatarLink: avatarLink ?? this.avatarLink,
      isActiv: isActiv ?? this.isActiv,
      isInGame: isInGame ?? this.isInGame,
      gamesCount: gamesCount ?? this.gamesCount,
      victoriesCount: victoriesCount ?? this.victoriesCount,
      friendsUidList: friendsUidList ?? this.friendsUidList,
      notificationsUidList: notificationsUidList ?? this.notificationsUidList,
    );
  }
}

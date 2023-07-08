// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:game/domain/entities/account.dart';

part 'account_model.g.dart';

/// This model contains all account data.
/// All accounts are stored in Firebase.
/// This model can be converted from [UserAccount] entity.
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
  @JsonKey(name: AccountSchema.isOnline)
  final bool isOnline;
  @JsonKey(name: AccountSchema.isInGame)
  final bool isInGame;
  @JsonKey(name: AccountSchema.inGameRoomId)
  final String inGameRoomId;
  @JsonKey(name: AccountSchema.gamesCount)
  final int gamesCount;
  @JsonKey(name: AccountSchema.victoriesCount)
  final int victoriesCount;
  @JsonKey(name: AccountSchema.friendsUidList)
  final List<String> friendsUidList;
  @JsonKey(name: AccountSchema.notificationsUidList)
  final List<String> notificationsUidList;

  const AccountModel({
    required this.username,
    required this.login,
    required this.uid,
    required this.avatarLink,
    required this.isOnline,
    required this.isInGame,
    required this.inGameRoomId,
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
        isOnline: userAccount.isOnline,
        isInGame: userAccount.isInGame,
        inGameRoomId: userAccount.inGameRoomId,
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
    bool? isOnline,
    bool? isInGame,
    String? inGameRoomId,
    int? gamesCount,
    int? victoriesCount,
    List<String>? friendsUidList,
    List<String>? notificationsUidList,
  }) {
    return AccountModel(
      username: username ?? this.username,
      login: login ?? this.login,
      uid: uid ?? this.uid,
      avatarLink: avatarLink ?? this.avatarLink,
      isOnline: isOnline ?? this.isOnline,
      isInGame: isInGame ?? this.isInGame,
      inGameRoomId: inGameRoomId ?? this.inGameRoomId,
      gamesCount: gamesCount ?? this.gamesCount,
      victoriesCount: victoriesCount ?? this.victoriesCount,
      friendsUidList: friendsUidList ?? this.friendsUidList,
      notificationsUidList: notificationsUidList ?? this.notificationsUidList,
    );
  }
}

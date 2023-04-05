// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      username: json['username'] as String,
      login: json['login'] as String,
      uid: json['uid'] as String,
      avatarLink: json['avatarLink'] as String?,
      isActiv: json['isActiv'] as bool,
      isInGame: json['isInGame'] as bool,
      gamesCount: json['gamesCount'] as int,
      victoriesCount: json['victoriesCount'] as int,
      friendsUidList:
          (json['friendsUidList'] as List<dynamic>).map((e) => e as String),
      notificationsUidList: (json['notificationsUidList'] as List<dynamic>)
          .map((e) => e as String),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'login': instance.login,
      'uid': instance.uid,
      'avatarLink': instance.avatarLink,
      'isActiv': instance.isActiv,
      'isInGame': instance.isInGame,
      'gamesCount': instance.gamesCount,
      'victoriesCount': instance.victoriesCount,
      'friendsUidList': instance.friendsUidList.toList(),
      'notificationsUidList': instance.notificationsUidList.toList(),
    };

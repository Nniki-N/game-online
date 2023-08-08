// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      uid: json['uid'] as String,
      sender: AccountModel.fromJson(json['sender'] as Map<String, dynamic>),
      notificationType:
          $enumDecode(_$NotificationTypesEnumMap, json['notificationType']),
      gameRoomModel:
          GameRoomModel.fromJson(json['gameRoom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'sender': instance.sender.toJson(),
      'notificationType':
          _$NotificationTypesEnumMap[instance.notificationType]!,
      'gameRoom': instance.gameRoomModel.toJson(),
    };

const _$NotificationTypesEnumMap = {
  NotificationTypes.gameOffer: 'gameOffer',
  NotificationTypes.gameOfferDenian: 'gameOfferDenian',
};

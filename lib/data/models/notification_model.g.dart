// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      uid: json['uid'] as String,
      title: json['title'] as String?,
      message: json['message'] as String,
      notificationType:
          $enumDecode(_$NotificationTypeEnumMap, json['notificationType']),
      sendingTime: DateTime.parse(json['sendingTime'] as String),
      senderUid: json['senderUid'] as String?,
      senderUsername: json['senderUsername'] as String?,
      senderAvatarLink: json['senderAvatarLink'] as String?,
      notificationOffer: $enumDecodeNullable(
          _$NotificationOfferEnumMap, json['notificationOffer']),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'message': instance.message,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType]!,
      'sendingTime': instance.sendingTime.toIso8601String(),
      'senderUid': instance.senderUid,
      'senderUsername': instance.senderUsername,
      'senderAvatarLink': instance.senderAvatarLink,
      'notificationOffer':
          _$NotificationOfferEnumMap[instance.notificationOffer],
    };

const _$NotificationTypeEnumMap = {
  NotificationType.textNotification: 'textNotification',
  NotificationType.notificationFromUser: 'notificationFromUser',
};

const _$NotificationOfferEnumMap = {
  NotificationOffer.friendshipOffer: 'friendshipOffer',
  NotificationOffer.gameOffer: 'gameOffer',
};

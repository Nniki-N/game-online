// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/notification_schema.dart';
import 'package:game/domain/entities/notification.dart';

part 'notification_model.g.dart';

/// This model consists from data that can be separated to different
/// notification types.
///
/// All notification are stored in Firebase.
///
/// This model can be converted in [TextNotification] and [NotificationFromUser]
/// entities.
@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: NotificationSchema.uid)
  final String uid;
  @JsonKey(name: NotificationSchema.title)
  final String? title;
  @JsonKey(name: NotificationSchema.message)
  final String message;
  @JsonKey(name: NotificationSchema.notificationType)
  final NotificationType notificationType;
  @JsonKey(name: NotificationSchema.sendingTime)
  final DateTime sendingTime;
  @JsonKey(name: NotificationSchema.senderUid)
  final String? senderUid;
  @JsonKey(name: NotificationSchema.senderUsername)
  final String? senderUsername;
  @JsonKey(name: NotificationSchema.senderAvatarLink)
  final String? senderAvatarLink;
  @JsonKey(name: NotificationSchema.notificationOffer)
  final NotificationOffer? notificationOffer;

  const NotificationModel({
    required this.uid,
    required this.title,
    required this.message,
    required this.notificationType,
    required this.sendingTime,
    required this.senderUid,
    required this.senderUsername,
    required this.senderAvatarLink,
    required this.notificationOffer,
  });

  factory NotificationModel.fromJson(Json json) =>
      _$NotificationModelFromJson(json);
  Json toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    String? uid,
    String? title,
    String? message,
    NotificationType? notificationType,
    DateTime? sendingTime,
    String? senderUid,
    String? senderUsername,
    String? senderAvatarLink,
    NotificationOffer? notificationOffer,
  }) {
    return NotificationModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      message: message ?? this.message,
      notificationType: notificationType ?? this.notificationType,
      sendingTime: sendingTime ?? this.sendingTime,
      senderUid: senderUid ?? this.senderUid,
      senderUsername: senderUsername ?? this.senderUsername,
      senderAvatarLink: senderAvatarLink ?? this.senderAvatarLink,
      notificationOffer: notificationOffer ?? this.notificationOffer,
    );
  }
}

enum NotificationType {
  textNotification,
  notificationFromUser,
}

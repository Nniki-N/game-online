import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/notification_schema.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

/// This model consists from data that can be separated to different
/// notification types.
///
/// All notification are stored in Firebase.
///
/// This model can be converted in [TextNotification] and [NotificationFromUser]
/// entities.
@immutable
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
}

enum NotificationType {
  textNotification,
  notificationFromUser,
}

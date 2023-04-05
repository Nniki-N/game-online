import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/notification_model.dart';

/// An abstract entity used to display and respond to notifications.
@immutable
abstract class Notification {
  final String uid;
  final String message;
  final DateTime sendingTime;

  const Notification({
    required this.uid,
    required this.message,
    required this.sendingTime,
  });
}

/// The [Notification] child entity is only used to display general message.
/// This entity can be converted from [NotificationModel] model.
@immutable
class TextNotification extends Notification {
  final String? title;

  const TextNotification({
    required String uid,
    required String message,
    required DateTime sendingTime,
    required this.title,
  }) : super(
          uid: uid,
          message: message,
          sendingTime: sendingTime,
        );

  factory TextNotification.fromNotificationModel({
    required NotificationModel notificationModel,
  }) =>
      TextNotification(
        uid: notificationModel.uid,
        message: notificationModel.message,
        sendingTime: notificationModel.sendingTime,
        title: notificationModel.title,
      );
}

/// The [Notification] child entity can be sent only by autorized users.
/// This entity contains [NotificationOffer] that refers to the available actions.
/// This entity can be converted from [NotificationModel] model.
@immutable
class NotificationFromUser extends Notification {
  final String? senderUsername;
  final String? senderUid;
  final String? senderAvatarLink;
  final NotificationOffer? notificationOffer;

  const NotificationFromUser({
    required String uid,
    required String message,
    required DateTime sendingTime,
    required this.senderUsername,
    required this.senderUid,
    required this.senderAvatarLink,
    required this.notificationOffer,
  }) : super(
          uid: uid,
          message: message,
          sendingTime: sendingTime,
        );

  factory NotificationFromUser.fromNotificationModel({
    required NotificationModel notificationModel,
  }) =>
      NotificationFromUser(
        uid: notificationModel.uid,
        message: notificationModel.message,
        sendingTime: notificationModel.sendingTime,
        senderUsername: notificationModel.senderUsername,
        senderUid: notificationModel.senderUid,
        senderAvatarLink: notificationModel.senderAvatarLink,
        notificationOffer: notificationModel.notificationOffer,
      );
}

enum NotificationOffer {
  friendshipOffer,
  gameOffer,
}

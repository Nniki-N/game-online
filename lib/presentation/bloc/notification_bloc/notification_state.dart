import 'package:flutter/foundation.dart';
import 'package:game/common/errors/notification_error.dart';
import 'package:game/domain/entities/notification.dart';

@immutable
abstract class NotificationState {
  final Notification? lastSentNotification;
  final String? recipientOfLastNotificationUid;
  final List<Notification> notificationsList;

  const NotificationState({
    this.lastSentNotification,
    this.recipientOfLastNotificationUid,
    required this.notificationsList,
  });
}

@immutable
class InitialNotificationState extends NotificationState {
  const InitialNotificationState({
    Notification? lastSentNotification,
    String? recipientOfLastNotificationUid,
    List<Notification> notificationList = const [],
  }) : super(
          lastSentNotification: lastSentNotification,
          recipientOfLastNotificationUid: recipientOfLastNotificationUid,
          notificationsList: notificationList,
        );
}

@immutable
class LoadedNotificationState extends NotificationState {
  const LoadedNotificationState({
    Notification? lastSentNotification,
    String? recipientOfLastNotificationUid,
    required List<Notification> notificationsList,
  }) : super(
          lastSentNotification: lastSentNotification,
          recipientOfLastNotificationUid: recipientOfLastNotificationUid,
          notificationsList: notificationsList,
        );
}

@immutable
class UnlistenedNotificationState extends NotificationState {
  const UnlistenedNotificationState() : super(notificationsList: const []);
}

@immutable
class ErrorNotificationState extends NotificationState {
  final NotificationError notificationError;

  const ErrorNotificationState({
    required this.notificationError,
    Notification? lastSentNotification,
    String? recipientOfLastNotificationUid,
    required List<Notification> notificationsList,
  }) : super(
          lastSentNotification: lastSentNotification,
          recipientOfLastNotificationUid: recipientOfLastNotificationUid,
          notificationsList: notificationsList,
        );
}

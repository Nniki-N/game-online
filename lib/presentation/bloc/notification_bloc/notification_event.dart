import 'package:flutter/foundation.dart';
import 'package:game/domain/entities/game_room.dart';

@immutable
abstract class NotificationEvent {
  const NotificationEvent();
}

@immutable
class InitializeNotificationEvent extends NotificationEvent {
  const InitializeNotificationEvent();
}

@immutable
class SendGameOfferNotificationEvent extends NotificationEvent {
  final String recipientUid;
  final GameRoom gameRoom;

  const SendGameOfferNotificationEvent({
    required this.recipientUid,
    required this.gameRoom,
  });
}

@immutable
class SendDenianOfGameOfferNotificationEvent extends NotificationEvent {
  final String recipientUid;
  final GameRoom gameRoom;

  const SendDenianOfGameOfferNotificationEvent({
    required this.recipientUid,
    required this.gameRoom,
  });
}

@immutable
class DeleteForCurrentUserNotificationEvent extends NotificationEvent {
  final String notificationUid;

  const DeleteForCurrentUserNotificationEvent({
    required this.notificationUid,
  });
}

@immutable
class DeleteLastSentNotification extends NotificationEvent {
  final String notificationUid;
  final String recipientUid;

  const DeleteLastSentNotification({
    required this.notificationUid,
    required this.recipientUid,
  });
}

@immutable
class StopListenUpdatesNotificationEvent extends NotificationEvent {
  const StopListenUpdatesNotificationEvent();
}

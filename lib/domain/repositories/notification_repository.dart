import 'package:flutter/foundation.dart';
import 'package:game/common/errors/notification_error.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/notification.dart';

@immutable
abstract class NotificationRepository {
  const NotificationRepository();

  /// Retrieves all notifications of a current user.
  ///
  /// Returns list of [Notification] if the request was successful.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorRetrievingNotificationsList] when any other error occurs.
  Future<List<Notification>> getNotificationsList();

  /// Sends a game offer notification. Saves the notification and adds
  /// notification to the recepient notifications list.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorSendingGameOffer] when any other error occurs.
  Future<Notification> sendGameOfferNotification({
    required String recipientUid,
    required GameRoom gameRoom,
  });

  /// Sends a game offer denial notification. Saves the notification and adds
  /// notification to the recepient notifications list.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorSendingGameOfferDenial] when any other error occurs.
  Future<Notification> sendGameOfferDenialNotification({
    required String recipientUid,
    required GameRoom gameRoom,
  });

  /// Deletes a notification.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorDeletingNotification] when any other error occurs.
  Future<void> deleteNotification({
    required String uid,
  });
}

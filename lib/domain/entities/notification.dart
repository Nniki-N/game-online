import 'package:flutter/foundation.dart' show immutable;

import 'package:game/data/models/notification_model.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/entities/game_room.dart';

@immutable
class Notification {
  final String uid;
  final UserAccount sender;
  final NotificationTypes notificationType;
  final GameRoom gameRoom;

  const Notification({
    required this.uid,
    required this.sender,
    required this.notificationType,
    required this.gameRoom,
  });

  factory Notification.fromNotificationModel({
    required NotificationModel notificationModel,
  }) {
    return Notification(
      uid: notificationModel.uid,
      sender: UserAccount.fromAccountModel(
        accountModel: notificationModel.sender,
      ),
      notificationType: notificationModel.notificationType,
      gameRoom: GameRoom.fromGameRoomModel(
              gameRoomModel: notificationModel.gameRoomModel,
            ),
    );
  }
}

enum NotificationTypes {
  gameOffer,
  gameOfferDenian,
}

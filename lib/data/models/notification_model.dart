
import 'package:game/data/models/game_room_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/schemas/notification_schema.dart';
import 'package:game/domain/entities/notification.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: NotificationSchema.uid)
  final String uid;
  @JsonKey(name: NotificationSchema.sender)
  final AccountModel sender;
  @JsonKey(name: NotificationSchema.notificationType)
  final NotificationTypes notificationType;
  @JsonKey(name: NotificationSchema.gameRoom)
  final GameRoomModel gameRoomModel;

  NotificationModel({
    required this.uid,
    required this.sender,
    required this.notificationType,
    required this.gameRoomModel,
  });

  factory NotificationModel.fromJson(Json json) =>
      _$NotificationModelFromJson(json);
  Json toJson() => _$NotificationModelToJson(this);

  factory NotificationModel.fromNotification({
    required Notification notification,
  }) {
    return NotificationModel(
      uid: notification.uid,
      sender: AccountModel.fromUserAccountEntity(
        userAccount: notification.sender,
      ),
      notificationType: notification.notificationType,
      gameRoomModel: GameRoomModel.fromGameRoomEntity(
              gameRoom: notification.gameRoom,
            ),
    );
  }
}

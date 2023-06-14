import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/game_room.dart';

@immutable
abstract class RoomEvent {
  const RoomEvent();
}

@immutable
class InitializeRoomEvent extends RoomEvent {
  const InitializeRoomEvent();
}

@immutable
class CreateRoomEvent extends RoomEvent {
  const CreateRoomEvent();
}

@immutable
class SearchRoomEvent extends RoomEvent {
  const SearchRoomEvent();
}

@immutable
class JoinRoomEvent extends RoomEvent {
  final GameRoom gameRoom;
  // final String gameRoomId;

  const JoinRoomEvent({
    required this.gameRoom,
  });
}

@immutable
class LeaveRoomEvent extends RoomEvent {
  final GameRoom gameRoom;
  final bool leaveAfterResult;
  // final String gameRoomId;

  const LeaveRoomEvent({
    required this.gameRoom,
    required this.leaveAfterResult,
  });
}

import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/game_room.dart';

@immutable
abstract class RoomState {
  const RoomState();
}

@immutable
class InitialRoomState extends RoomState {
  const InitialRoomState();
}

@immutable
class SearchingRoomState extends RoomState {
  const SearchingRoomState();
}

@immutable
class LoadingRoomState extends RoomState {
  const LoadingRoomState();
}

// @immutable
// class WaitingRoomState extends RoomState {
//   final GameRoom gameRoom;

//   const WaitingRoomState({
//     required this.gameRoom,
//   });
// }

// @immutable
// class CreatedRoomState extends RoomState {
//   final GameRoom gameRoom;
//
//   const CreatedRoomState({
//     required this.gameRoom,
//   });
// }

@immutable
class InRoomState extends RoomState {
  final GameRoom gameRoom;

  const InRoomState({
    required this.gameRoom,
  });
}

@immutable
class InFullRoomState extends RoomState {
  final GameRoom gameRoom;

  const InFullRoomState({
    required this.gameRoom,
  });
}

@immutable
class OutsideRoomState extends RoomState {
  const OutsideRoomState();
}

@immutable
class ErrorRoomState extends RoomState {
  final String errorTitle;
  final String errorText;

  const ErrorRoomState({
    this.errorTitle = '',
    required this.errorText,
  });
}

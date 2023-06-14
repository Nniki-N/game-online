import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/game_room.dart';

@immutable
abstract class GameState {
  final GameRoom gameRoom;

  const GameState({
    required this.gameRoom,
  });
}

@immutable
class InitialGameState extends GameState {
  const InitialGameState({
    required GameRoom gameRoom,
  }) : super(gameRoom: gameRoom);
}

@immutable
class LoadingGameState extends GameState {
  const LoadingGameState({
    required GameRoom gameRoom,
  }) : super(gameRoom: gameRoom);
}

@immutable
class InProgressGameState extends GameState {
  const InProgressGameState({
    required GameRoom gameRoom,
  }) : super(gameRoom: gameRoom);
}

@immutable
class ResultGameState extends GameState {
  const ResultGameState({
    required GameRoom gameRoom,
  }) : super(gameRoom: gameRoom);
}

@immutable
class ErrorGameState extends GameState {
  final String errorTitle;
  final String errorText;

  const ErrorGameState({
    this.errorTitle = '',
    required this.errorText,
    required GameRoom gameRoom,
  }) : super(gameRoom: gameRoom);
}

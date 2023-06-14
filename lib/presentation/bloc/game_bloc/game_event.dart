import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';

@immutable
abstract class GameEvent {
  const GameEvent();
}

@immutable
class InitializeGameEvent extends GameEvent {
  const InitializeGameEvent();
}

@immutable
class StartGameEvent extends GameEvent {
  const StartGameEvent();
}

@immutable
class FinishGameEvent extends GameEvent {
  final GameRoom gameRoom;
  final String winnerUid;

  const FinishGameEvent({
    required this.gameRoom,
    required this.winnerUid,
  });
}

@immutable
class RestartGameEvent extends GameEvent {
  const RestartGameEvent();
}

@immutable
class GiveUpGameEvent extends GameEvent {
  const GiveUpGameEvent();
}

@immutable
class MakeMoveGameEvent extends GameEvent {
  final Chips chipSize;
  final int indexI;
  final int indexJ;

  const MakeMoveGameEvent({
    required this.chipSize,
    required this.indexI,
    required this.indexJ,
  });
}

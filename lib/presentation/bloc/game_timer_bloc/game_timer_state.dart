import 'package:flutter/foundation.dart';
import 'package:game/common/errors/game_timer_error.dart';
import 'package:game/domain/repositories/game_timer_repository.dart';

@immutable
abstract class GameTimerState {
  final int secondsLeft;

  const GameTimerState({
    required this.secondsLeft,
  });
}

@immutable
class InitialGameTimerState extends GameTimerState {
  const InitialGameTimerState({
    int secondsLeft = GameTimerRepository.gameTimerDurationForCurrentUserInSeconds,
  }) : super(secondsLeft: secondsLeft);
}

@immutable
class InProgressGameTimerState extends GameTimerState {
  const InProgressGameTimerState({
    required int secondsLeft,
  }) : super(secondsLeft: secondsLeft);
}

@immutable
class StoppedGameTimerState extends GameTimerState {
  const StoppedGameTimerState({
    required int secondsLeft,
  }) : super(secondsLeft: secondsLeft);
}

@immutable
class StoppedSecondGameTimerState extends GameTimerState {
  const StoppedSecondGameTimerState({
    required int secondsLeft,
  }) : super(secondsLeft: secondsLeft);
}

@immutable
class ErrorGameTimerState extends GameTimerState {
  final GameTimerError gameTimerError;

  const ErrorGameTimerState({
    required this.gameTimerError,
    required int secondsLeft,
  }) : super(secondsLeft: secondsLeft);
}

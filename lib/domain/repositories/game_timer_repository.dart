import 'package:flutter/foundation.dart';

@immutable
abstract class GameTimerRepository {
  static const int gameTimerDurationForCurrentUserInSeconds = 30;
  static const int gameTimerDurationForSecondPlayerInSeconds = gameTimerDurationForCurrentUserInSeconds + 15;

  const GameTimerRepository();

  /// Returns a periodic stream of ints that indicates how many seconds are left.
  /// 
  /// By default [timerDurationInSeconds] equals [gameTimerDurationForCurrentUserInSeconds].
  Stream<int> gameTimerStreamForCurrentUser({
    int timerDurationInSeconds = gameTimerDurationForCurrentUserInSeconds,
  });
  
  /// Returns a periodic stream of ints that indicates how many seconds are left.
  /// 
  /// By default [timerDurationInSeconds] equals [gameTimerDurationForSecondPlayerInSeconds].
  Stream<int> gameTimerStreamForSecondPlayer({
    int timerDurationInSeconds = gameTimerDurationForSecondPlayerInSeconds,
  });
}

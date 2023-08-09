import 'package:flutter/foundation.dart';
import 'package:game/domain/repositories/game_timer_repository.dart';

@immutable
class IGameTimerRepository extends GameTimerRepository {
  const IGameTimerRepository();

  /// Returns a periodic stream of ints that indicates how many seconds are left.
  /// 
  /// By default [timerDurationInSeconds] equals [gameTimerDurationForCurrentUserInSeconds].
  @override
  Stream<int> gameTimerStreamForCurrentUser({
    int timerDurationInSeconds = GameTimerRepository.gameTimerDurationForCurrentUserInSeconds,
  }) {
    return Stream.periodic(const Duration(seconds: 1), (x) => timerDurationInSeconds - x - 1)
        .take(timerDurationInSeconds);
  }
  
  /// Returns a periodic stream of ints that indicates how many seconds are left.
  /// 
  /// By default [timerDurationInSeconds] equals [gameTimerDurationForSecondPlayerInSeconds].
  @override
  Stream<int> gameTimerStreamForSecondPlayer({
    int timerDurationInSeconds = GameTimerRepository.gameTimerDurationForSecondPlayerInSeconds,
  }) {
    return Stream.periodic(const Duration(seconds: 1), (x) => timerDurationInSeconds - x - 1)
        .take(timerDurationInSeconds);
  }
}

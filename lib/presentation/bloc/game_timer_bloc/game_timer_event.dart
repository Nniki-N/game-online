import 'package:flutter/foundation.dart';

@immutable
abstract class GameTimerEvent {
  const GameTimerEvent();
}


@immutable
class StartCooldownGameTimerEvent extends GameTimerEvent {
  const StartCooldownGameTimerEvent();
}

@immutable
class StopCooldownGameTimerEvent extends GameTimerEvent {
  const StopCooldownGameTimerEvent();
}

@immutable
class StartCooldownForSecondPlayerGameTimerEvent extends GameTimerEvent {
  const StartCooldownForSecondPlayerGameTimerEvent();
}

@immutable
class StopCooldownForSecondPlayerGameTimerEvent extends GameTimerEvent {
  const StopCooldownForSecondPlayerGameTimerEvent();
}

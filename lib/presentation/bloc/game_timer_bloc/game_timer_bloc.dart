import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/game_timer_error.dart';
import 'package:game/domain/repositories/game_timer_repository.dart';
import 'package:game/presentation/bloc/game_timer_bloc/game_timer_event.dart';
import 'package:game/presentation/bloc/game_timer_bloc/game_timer_state.dart';

class GameTimerBloc extends Bloc<GameTimerEvent, GameTimerState> {
  final GameTimerRepository _gameTimerRepository;
  late StreamSubscription _streamSubscription;

  GameTimerBloc({required GameTimerRepository gameTimerRepository})
      : _gameTimerRepository = gameTimerRepository,
        super(const InitialGameTimerState()) {
    on<StartCooldownGameTimerEvent>(_startCooldown);
    on<StopCooldownGameTimerEvent>(_stopCooldown);
    on<StartCooldownForSecondPlayerGameTimerEvent>(
      _startCooldownForSecondPlayer,
    );
    on<StopCooldownForSecondPlayerGameTimerEvent>(
      _stopCooldownForSecondPlayer,
    );
  }

  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _streamSubscription.cancel();
    });
  }

  /// Starts a cooldown of the game timer.
  Future<void> _startCooldown(
    StartCooldownGameTimerEvent event,
    Emitter<GameTimerState> emit,
  ) async {
    try {
      // Indicates that the cooldown started.
      emit(const InProgressGameTimerState(
        secondsLeft: GameTimerRepository.gameTimerDurationForCurrentUserInSeconds,
      ));

      // Changes state base on how many seconds are left for a move.
      await _listenStream(
        _gameTimerRepository.gameTimerStreamForCurrentUser(),
        onData: (secondsLeft) {
          emit(InProgressGameTimerState(secondsLeft: secondsLeft));
        },
        onError: (error, stackTrace) {
          emit(ErrorGameTimerState(
            gameTimerError: const GameTimerErrorUnknown(),
            secondsLeft: state.secondsLeft,
          ));
        },
      );
    } catch (exeption) {
      emit(ErrorGameTimerState(
        gameTimerError: const GameTimerErrorUnknown(),
        secondsLeft: state.secondsLeft,
      ));
    }
  }

  /// Stops a cooldown of the game timer.
  Future<void> _stopCooldown(
    StopCooldownGameTimerEvent event,
    Emitter<GameTimerState> emit,
  ) async {
    try {
      // Stops cooldown for a current user.
      await _streamSubscription.cancel();

      // Indicates that the cooldown was stopped.
      emit(StoppedGameTimerState(secondsLeft: state.secondsLeft));
    } catch (exeption) {
      emit(ErrorGameTimerState(
        gameTimerError: const GameTimerErrorUnknown(),
        secondsLeft: state.secondsLeft,
      ));
    }
  }

  /// Starts a cooldown of the game timer for a second player.
  Future<void> _startCooldownForSecondPlayer(
    StartCooldownForSecondPlayerGameTimerEvent event,
    Emitter<GameTimerState> emit,
  ) async {
    try {
      // Changes state base on how many seconds are left for a second player's move.
      await _listenStream(
        _gameTimerRepository.gameTimerStreamForSecondPlayer(),
        onData: (secondsLeft) {
          // Indicates that second player is not in the game.
          if (secondsLeft == 0) {
            emit(const StoppedSecondGameTimerState(
              secondsLeft: GameTimerRepository.gameTimerDurationForCurrentUserInSeconds,
            ));
          }
        },
        onError: (error, stackTrace) {
          emit(ErrorGameTimerState(
            gameTimerError: const GameTimerErrorUnknown(),
            secondsLeft: state.secondsLeft,
          ));
        },
      );
    } catch (exeption) {
      emit(ErrorGameTimerState(
        gameTimerError: const GameTimerErrorUnknown(),
        secondsLeft: state.secondsLeft,
      ));
    }
  }

  /// Stops a cooldown of the game timer.
  Future<void> _stopCooldownForSecondPlayer(
    StopCooldownForSecondPlayerGameTimerEvent event,
    Emitter<GameTimerState> emit,
  ) async {
    try {
      // Stops cooldown for a second player.
      await _streamSubscription.cancel();
    } catch (exeption) {
      emit(ErrorGameTimerState(
        gameTimerError: const GameTimerErrorUnknown(),
        secondsLeft: state.secondsLeft,
      ));
    }
  }

  /// Closes the stream subscriptions.
  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}

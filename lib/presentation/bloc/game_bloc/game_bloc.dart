import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/domain/repositories/game_repository.dart';
import 'package:game/domain/repositories/room_repository.dart';
import 'package:game/presentation/bloc/game_bloc/game_event.dart';
import 'package:game/presentation/bloc/game_bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _gameRepository;
  final RoomRepository _roomRepository;
  final AccountRepository _accountRepository;
  late StreamSubscription _streamSubscription;

  GameBloc({
    required GameRepository gameRepository,
    required RoomRepository roomRepository,
    required AccountRepository accountRepository,
    required GameRoom gameRoom,
  })  : _gameRepository = gameRepository,
        _roomRepository = roomRepository,
        _accountRepository = accountRepository,
        super(InitialGameState(gameRoom: gameRoom)) {
    on<InitializeGameEvent>(_init, transformer: droppable());
    on<StartGameEvent>(_startGame);
    on<FinishGameEvent>(_finishGame);
    on<FinishGameWithoutRestartPosibilityEvent>(
        _finishGameWithoutRestartPosibility);
    on<RestartGameEvent>(_restartGame, transformer: droppable());
    on<GiveUpGameEvent>(_giveUp);
    on<MakeMoveGameEvent>(_makeMove);
  }

  /// Initializes the game.
  ///
  /// Changes the state of the game base on the game room data chages.
  Future<void> _init(
    InitializeGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Retrieves a stream of game room data changes.
      final Stream<GameRoom> gameRoomStream = _roomRepository
          .getGameRoomStream(gameRoomId: state.gameRoom.uid)
          .asBroadcastStream();

      // Responds to the game room state changes.
      // await emit.onEach(
      //   gameRoomStream,
      //   onData: (gameRoom) {
      //     // Continues game if the game state remains as in progress.
      //     if (gameRoom.gameRoomState == GameRoomState.inGame) {
      //       log('GameBloc ------------------ game is an "inGame" ');
      //       emit(InProgressGameState(gameRoom: gameRoom.copyWith()));
      //     }
      //
      //     // Finishes the game if the game state was changed to the result.
      //     else if (gameRoom.gameRoomState == GameRoomState.result) {
      //       log('GameBloc ------------------ game state is a "result"');
      //       emit(ResultGameState(gameRoom: gameRoom));
      //     }
      //   },
      //   // Closes the stream listening if any arror occurs.
      //   onError: (error, stackTrace) {
      //     log('RoomBloc ------------------ stream error: ${error.toString()}');
      //   },
      // );

      await _listenStream(
        gameRoomStream,
        onData: (gameRoom) {
          // Continues game if the game state remains as in progress.
          if (gameRoom.gameRoomState == GameRoomState.inGame) {
            log('GameBloc ------------------ game is an "inGame" ');
            emit(InProgressGameState(gameRoom: gameRoom.copyWith()));
          }

          // Finishes the game if the game state was changed to the result.
          else if (gameRoom.gameRoomState == GameRoomState.result) {
            log('GameBloc ------------------ game state is a "result"');
            emit(ResultGameState(gameRoom: gameRoom));
          }
        },
        // Closes the stream listening if any arror occurs.
        onError: (error, stackTrace) {
          log('RoomBloc ------------------ stream error: ${error.toString()}');
        },
      );
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    }
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

  /// Starts the game.
  ///
  /// Changes the state of the game to show that the game is in the progress.
  Future<void> _startGame(
    StartGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      GameRoom gameRoom = state.gameRoom;

      // Resets the chips count for both players.
      Player firstPlayer = gameRoom.players.first.copyWith(chipsCount: {
        Chips.chipSize1: 3,
        Chips.chipSize2: 3,
        Chips.chipSize3: 3,
      });
      Player secondPlayer = gameRoom.players.last.copyWith(chipsCount: {
        Chips.chipSize1: 3,
        Chips.chipSize2: 3,
        Chips.chipSize3: 3,
      });

      // Resets field with chips.
      gameRoom = gameRoom.copyWith(
        players: [firstPlayer, secondPlayer],
        gameRoomState: GameRoomState.inGame,
        winnerUid: '',
        fieldWithChips: [
          [null, null, null],
          [null, null, null],
          [null, null, null],
        ],
      );

      // Saves changes of the game room.
      await _roomRepository.updateGameRoom(gameRoom: gameRoom);

      // Indicates that the game started and players can play.
      emit(InProgressGameState(gameRoom: gameRoom));
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Finishes the game and sets the winner to the result.
  ///
  /// Updates players total and victory counts.
  Future<void> _finishGame(
    FinishGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      // Probably not needed, but let it be here for a while.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      final String winnerUid = event.winnerUid;

      // Changes the game state and sets the winner
      GameRoom gameRoom = state.gameRoom.copyWith(
        gameRoomState: GameRoomState.result,
        winnerUid: winnerUid,
      );

      await _roomRepository.updateGameRoom(gameRoom: gameRoom);

      // Indicates that the game has finished and shows game results.
      // Probably not needed, but let it be here for a while.
      emit(ResultGameState(gameRoom: gameRoom));

      // The length equals 1 only if the oponent left the game right before or
      // in the process of calling FinishGameEvent.
      if (gameRoom.players.length == 2) {
        // Retrieves players user data.
        UserAccount currentUserAccount =
            await _accountRepository.getCurrentUserAccount();
        UserAccount oponentUserAccount =
            await _accountRepository.getUserAccount(
          uid: gameRoom.players
              .firstWhere((player) => player.uid != currentUserAccount.uid)
              .uid,
        );

        // Sets total and victory counts to players according to the game result.
        if (currentUserAccount.uid == winnerUid) {
          currentUserAccount = currentUserAccount.copyWith(
            gamesCount: currentUserAccount.gamesCount + 1,
            victoriesCount: currentUserAccount.victoriesCount + 1,
          );
          oponentUserAccount = oponentUserAccount.copyWith(
            gamesCount: oponentUserAccount.gamesCount + 1,
          );
        } else {
          currentUserAccount = currentUserAccount.copyWith(
            gamesCount: currentUserAccount.gamesCount + 1,
          );
          oponentUserAccount = oponentUserAccount.copyWith(
            gamesCount: oponentUserAccount.gamesCount + 1,
            victoriesCount: oponentUserAccount.victoriesCount + 1,
          );
        }

        // Updates players total and victory counts.
        _accountRepository.updateUserAccount(userAccount: currentUserAccount);
        _accountRepository.updateUserAccount(userAccount: oponentUserAccount);
      } else {
        // Retrieves the current user data.
        UserAccount currentUserAccount =
            await _accountRepository.getCurrentUserAccount();

        // Sets total and victory counts of a current user according.
        currentUserAccount = currentUserAccount.copyWith(
          gamesCount: currentUserAccount.gamesCount + 1,
          victoriesCount: currentUserAccount.victoriesCount + 1,
        );

        // Updates current user total and victory counts.
        _accountRepository.updateUserAccount(userAccount: currentUserAccount);
      }
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        gameRoomError: GameRoomErrorUnknown(errorTitle: exception.toString()),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Finishes the game without restart posibility and sets the winner to the result.
  ///
  /// Updates players total and victory counts.
  Future<void> _finishGameWithoutRestartPosibility(
    FinishGameWithoutRestartPosibilityEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      // Probably not needed, but let it be here for a while.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      final String winnerUid = event.winnerUid;

      // Changes the game state and sets the winner
      GameRoom gameRoom = state.gameRoom.copyWith(
        gameRoomState: GameRoomState.result,
        winnerUid: winnerUid,
      );

      // Cancels a stream subscription that is used to change game bloc states.
      await _streamSubscription.cancel();

      // The length equals 1 only if the oponent left the game right before or
      // in the process of calling FinishGameEvent.
      if (gameRoom.players.length == 2) {
        // Retrieves players user data.
        UserAccount currentUserAccount =
            await _accountRepository.getCurrentUserAccount();
        UserAccount oponentUserAccount =
            await _accountRepository.getUserAccount(
          uid: gameRoom.players
              .firstWhere((player) => player.uid != currentUserAccount.uid)
              .uid,
        );

        // Sets total and victory counts to players according to the game result.
        if (currentUserAccount.uid == winnerUid) {
          currentUserAccount = currentUserAccount.copyWith(
            gamesCount: currentUserAccount.gamesCount + 1,
            victoriesCount: currentUserAccount.victoriesCount + 1,
          );
          oponentUserAccount = oponentUserAccount.copyWith(
            gamesCount: oponentUserAccount.gamesCount + 1,
          );
        } else {
          currentUserAccount = currentUserAccount.copyWith(
            gamesCount: currentUserAccount.gamesCount + 1,
          );
          oponentUserAccount = oponentUserAccount.copyWith(
            gamesCount: oponentUserAccount.gamesCount + 1,
            victoriesCount: oponentUserAccount.victoriesCount + 1,
          );
        }

        // Updates players total and victory counts.
        _accountRepository.updateUserAccount(userAccount: currentUserAccount);
        _accountRepository.updateUserAccount(userAccount: oponentUserAccount);
      } else {
        // Retrieves the current user data.
        UserAccount currentUserAccount =
            await _accountRepository.getCurrentUserAccount();

        // Sets total and victory counts of a current user according.
        currentUserAccount = currentUserAccount.copyWith(
          gamesCount: currentUserAccount.gamesCount + 1,
          victoriesCount: currentUserAccount.victoriesCount + 1,
        );

        // Updates current user total and victory counts.
        _accountRepository.updateUserAccount(userAccount: currentUserAccount);
      }

      // Indicates that the game has finished without a restart posibility and shows game results.
      emit(ResultWithoutRestartPosibilityGameState(gameRoom: gameRoom));
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        gameRoomError: GameRoomErrorUnknown(errorTitle: exception.toString()),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Restarts the game.
  ///
  /// Resets the chips count for both players, switches the turn of the first player,
  /// resets field with chips.
  Future<void> _restartGame(
    RestartGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      GameRoom gameRoom = state.gameRoom;

      List<Player> players = gameRoom.players;

      // Resets the chips count for players.
      players = players
          .map(
            (player) => player.copyWith(
              chipsCount: {
                Chips.chipSize1: 3,
                Chips.chipSize2: 3,
                Chips.chipSize3: 3,
              },
            ),
          )
          .toList();

      // Switches first and second player and the turn of the first player.
      if (gameRoom.winnerUid.trim().isNotEmpty) {
        players = players.reversed.toList();
      }

      // Resets field with chips.
      gameRoom = gameRoom.copyWith(
        players: players,
        gameRoomState: GameRoomState.inGame,
        winnerUid: '',
        turnOfPlayerUid: players.first.uid,
        fieldWithChips: [
          [null, null, null],
          [null, null, null],
          [null, null, null],
        ],
      );

      // Saves changes of the game room.
      await _roomRepository.updateGameRoom(gameRoom: gameRoom);

      // Indicates that the game started and players can play.
      emit(InProgressGameState(gameRoom: gameRoom));
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Finishes the game.
  ///
  /// Selects the winner uid and calls [FinishGameEvent] event.
  Future<void> _giveUp(
    GiveUpGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      // Retrieves the current user data.
      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      List<Player> players = state.gameRoom.players;

      // Selects the winner uid from the list of players.
      final String winnerUid = players
          .firstWhere(
            (player) => player.uid != currentUserAccount.uid,
            orElse: () => players.first,
          )
          .uid;

      add(FinishGameEvent(
        gameRoom: state.gameRoom,
        winnerUid: winnerUid,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        gameRoomError: GameRoomErrorUnknown(errorTitle: exception.toString()),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Puts a chip on the field.
  ///
  /// Changes the field with chips, number of chips of the current user.
  ///
  /// If there already is victory combination, calls a [FinishGameEvent] event
  /// to set a winner.
  /// If a next player can not make a move, calls a [FinishGameEvent] event to set
  /// the result as a draw.
  ///
  /// Throws [GameRoomErrorInvalidPlayerMove] if move is not possible.
  Future<void> _makeMove(
    MakeMoveGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom.copyWith()));

      GameRoom gameRoom = state.gameRoom;

      List<List<Chip?>> fieldWithChips = gameRoom.fieldWithChips;

      // Selects a chip on the position [indexI] [indexJ] of the field.
      final Chip? currentChipOnPositionIJ =
          fieldWithChips[event.indexI][event.indexJ];

      // Compares chips and decides if move is possible.
      if (currentChipOnPositionIJ != null &&
          event.chipSize.index <= currentChipOnPositionIJ.chipSize.index) {
        throw const GameRoomErrorInvalidPlayerMove();
      }

      // Retrieves the current user data.
      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Creates chip.
      final Chip chipToPutOnPositionIJ = Chip(
        chipSize: event.chipSize,
        chipOfPlayerUid: currentUserAccount.uid,
      );

      // Insers the chip in the position [i] [j] of the field.
      fieldWithChips[event.indexI][event.indexJ] = chipToPutOnPositionIJ;

      Player currentPlayer = gameRoom.players
          .firstWhere((player) => player.uid == currentUserAccount.uid);

      // Removes one chip from the current player.
      currentPlayer = currentPlayer.copyWith(chipsCount: {
        Chips.chipSize1:
            chipToPutOnPositionIJ.chipSize.index == Chips.chipSize1.index
                ? currentPlayer.chipsCount[Chips.chipSize1]! - 1
                : currentPlayer.chipsCount[Chips.chipSize1]!,
        Chips.chipSize2:
            chipToPutOnPositionIJ.chipSize.index == Chips.chipSize2.index
                ? currentPlayer.chipsCount[Chips.chipSize2]! - 1
                : currentPlayer.chipsCount[Chips.chipSize2]!,
        Chips.chipSize3:
            chipToPutOnPositionIJ.chipSize.index == Chips.chipSize3.index
                ? currentPlayer.chipsCount[Chips.chipSize3]! - 1
                : currentPlayer.chipsCount[Chips.chipSize3]!,
      });

      // Changes a chips count of the current user.
      gameRoom = _gameRepository.changePlayerDataInGameRoom(
        gameRoom: gameRoom,
        player: currentPlayer,
      );

      // Changes the field with chips.
      gameRoom = gameRoom.copyWith(fieldWithChips: fieldWithChips);

      // Changes the turn for a next player.
      gameRoom = _gameRepository.changeTurnForNextPlayer(gameRoom: gameRoom);

      // Checks the field for a victory combination.
      final String? winnerUid = _gameRepository
          .checkCombinationsAndSelectWinner(fieldWithChips: fieldWithChips);

      // Finishes the game if there is a winner.
      if (winnerUid != null) {
        add(FinishGameEvent(
          gameRoom: gameRoom,
          winnerUid: winnerUid,
        ));
      } else {
        // A next player to make a move.
        final Player playerToMakeMove = gameRoom.players.firstWhere(
          (player) => player.uid == gameRoom.turnOfPlayerUid,
        );

        // Checks if a next move is possible.
        final bool moveIsPossible = _gameRepository.moveIsPossible(
          fieldWithChips: fieldWithChips,
          player: playerToMakeMove,
        );

        // Continues the game if a next move is possible.
        // Finishes the game if a next move is impossible.
        if (moveIsPossible) {
          // Saves all changes.
          await _roomRepository.updateGameRoom(gameRoom: gameRoom);

          // Indicates that the game can continue.
          emit(InProgressGameState(gameRoom: gameRoom));
        } else {
          add(FinishGameEvent(
            gameRoom: gameRoom,
            winnerUid: '',
          ));
        }
      }
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        gameRoomError: gameRoomError,
        gameRoom: state.gameRoom,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        gameRoomError: GameRoomErrorUnknown(errorTitle: exception.toString()),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Closes the stream subscription.
  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}

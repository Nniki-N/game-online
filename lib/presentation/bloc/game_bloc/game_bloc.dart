import 'dart:async';

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

  GameBloc({
    required GameRepository gameRepository,
    required RoomRepository roomRepository,
    required AccountRepository accountRepository,
    required GameRoom gameRoom,
  })  : _gameRepository = gameRepository,
        _roomRepository = roomRepository,
        _accountRepository = accountRepository,
        super(InitialGameState(gameRoom: gameRoom)) {
    on<InitializeGameEvent>(_init);
    on<StartGameEvent>(_startGame, transformer: sequential());
    on<FinishGameEvent>(_finishGame, transformer: droppable());
    on<RestartGameEvent>(_restartGame, transformer: droppable());
    on<GiveUpGameEvent>(_giveUpGame, transformer: sequential());
    on<MakeMoveGameEvent>(_makeMoveGame, transformer: sequential());
  }

  /// add stream to catch user changes and change state
  /// think about implementing stream like in the spy-master
  Future<void> _init(
    InitializeGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Retrieves an account data of the current user.
      // final UserAccount currentUserAccount =
      //     await _accountRepository.getCurrentUserAccount();

      // Retrieves a stream of game room data changes.
      final Stream<GameRoom> gameRoomStream = _roomRepository.getGameRoomStream(
        gameRoomId: state.gameRoom.uid,
      );

      // final StreamSubscription<GameRoom> gameRoomStreamSubscription =
      gameRoomStream.listen((gameRoom) {
        // Finishes the game if the game state was changed to the result.
        if (gameRoom.gameRoomState == GameRoomState.result &&
            state is ResultGameState) {
          add(FinishGameEvent(
            gameRoom: gameRoom,
            winnerUid: gameRoom.winnerUid,
          ));
        }
        // Continues game if the game state remains as in progress.
        else if (gameRoom.gameRoomState == GameRoomState.inGame &&
            state is InProgressGameState) {
          emit(InProgressGameState(gameRoom: gameRoom));
        }
      });
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Starts the game.
  ///
  /// Changes the state of the game to show that the game is in the progress.
  ///
  /// Throws [GameRoomErrorNotTwoPlayers] if there are not 2 players in the game.
  Future<void> _startGame(
    StartGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom));

      // Changes the game state
      GameRoom gameRoom = state.gameRoom.copyWith(
        gameRoomState: GameRoomState.inGame,
      );

      // Throws error if something happened and there are two players.
      // But this should not happen, so try to check and change later !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      if (gameRoom.players.length != 2) {
        throw const GameRoomErrorNotTwoPlayers();
      }

      // Indicates that the game started and players can play.
      emit(InProgressGameState(gameRoom: gameRoom));
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorGameState(
        errorTitle: gameRoomError.errorTitle,
        errorText: gameRoomError.errorText,
        gameRoom: state.gameRoom,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Finishes the game and sets the winner to the result.
  ///
  /// Updates current user total and victory counts.
  Future<void> _finishGame(
    FinishGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      // Probably not needed, but let it be here for a while.
      emit(LoadingGameState(gameRoom: state.gameRoom));

      final String winnerUid = event.winnerUid;

      // Changes the game state and sets the winner
      GameRoom gameRoom = state.gameRoom.copyWith(
        gameRoomState: GameRoomState.result,
        winnerUid: winnerUid,
      );

      await _roomRepository.updateGameRoom(gameRoom: gameRoom);

      // Indicates that the game has finished and shows game results.
      emit(ResultGameState(gameRoom: gameRoom));

      // Retrieves the current user data.
      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Sets total and victory counts to the current user according to the game result.
      if (currentUserAccount.uid == winnerUid) {
        currentUserAccount = currentUserAccount.copyWith(
          gamesCount: currentUserAccount.gamesCount + 1,
          victoriesCount: currentUserAccount.victoriesCount + 1,
        );
      } else {
        currentUserAccount = currentUserAccount.copyWith(
          gamesCount: currentUserAccount.gamesCount + 1,
        );
      }

      // Updates current user total and victory counts.
      _accountRepository.updateUserAccount(userAccount: currentUserAccount);
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
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
      emit(LoadingGameState(gameRoom: state.gameRoom));

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

      // Switches first and second player and the turn of the first player.
      // Resets field with chips.
      gameRoom = gameRoom.copyWith(
        players: [secondPlayer, firstPlayer],
        gameRoomState: GameRoomState.inGame,
        winnerUid: '',
        turnOfPlayerUid: secondPlayer.uid,
        fieldWithChips: [[]],
      );

      // Saves changes of the game room.
      await _roomRepository.updateGameRoom(gameRoom: gameRoom);

      // Indicates that the game started and players can play.
      emit(InProgressGameState(gameRoom: gameRoom));
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
        gameRoom: state.gameRoom,
      ));
    }
  }

  /// Finishes the game.
  ///
  /// Selects the winner uid and calls [FinishGameEvent] event.
  Future<void> _giveUpGame(
    GiveUpGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom));

      // Retrieves the current user data.
      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Selects the winner uid from the list of players.
      final String winnerUid = state.gameRoom.players
          .firstWhere((player) => player.uid != currentUserAccount.uid)
          .uid;

      add(FinishGameEvent(
        gameRoom: state.gameRoom,
        winnerUid: winnerUid,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
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
  Future<void> _makeMoveGame(
    MakeMoveGameEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Shows loading.
      emit(LoadingGameState(gameRoom: state.gameRoom));

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

      // Changes field with chips.
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
        errorTitle: gameRoomError.errorTitle,
        errorText: gameRoomError.errorText,
        gameRoom: state.gameRoom,
      ));
    } catch (exception) {
      emit(ErrorGameState(
        errorText: exception.toString(),
        gameRoom: state.gameRoom,
      ));
    }
  }
}

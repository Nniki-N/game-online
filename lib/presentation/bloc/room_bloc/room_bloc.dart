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
import 'package:game/domain/repositories/room_repository.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository _roomRepository;
  final AccountRepository _accountRepository;

  RoomBloc({
    required RoomRepository roomRepository,
    required AccountRepository accountRepository,
  })  : _roomRepository = roomRepository,
        _accountRepository = accountRepository,
        super(const InitialRoomState()) {
    on<InitializeRoomEvent>(_init, transformer: droppable());
    on<SearchRoomEvent>(_searchGameRoom, transformer: droppable());
    on<CreateRoomEvent>(_createGameRoom, transformer: sequential());
    on<JoinRoomEvent>(_joinGameRoom, transformer: sequential());
    on<LeaveRoomEvent>(_leaveGameRoom, transformer: sequential());
  }

  /// later implement leaving here when internet connection is down
  Future<void> _init(InitializeRoomEvent event, Emitter<RoomState> emit) async {
    // A stream subscription for a game room is used when new room is created.
    StreamSubscription<GameRoom>? gameRoomSubscription;

    await emit.onEach(
      stream,
      onData: (roomState) async {
        // Indicates that two players are in the room.
        // Indicates that the room is empty.
        if (roomState is InRoomState) {
          // Retrieves a stream of game room data changes.
          final Stream<GameRoom> gameRoomStream =
              _roomRepository.getGameRoomStream(
            gameRoomId: roomState.gameRoom.uid,
          );

          // Cancels previous subscription just in case.
          await gameRoomSubscription?.cancel();

          // Changes state base on the number of players
          gameRoomSubscription = gameRoomStream.listen((gameRoom) {
            if (gameRoom.players.length == 1) {
              emit(InRoomState(gameRoom: gameRoom));
            } else if (gameRoom.players.length == 2) {
              emit(InFullRoomState(gameRoom: gameRoom));
            } else if (gameRoom.players.isEmpty) {
              emit(const OutsideRoomState());
            }
          });
        }

        if (roomState is OutsideRoomState) {
          await gameRoomSubscription?.cancel();
        }
      },
      onError: (error, stackTrace) {
        log(error.toString());
        emit(ErrorRoomState(errorText: error.toString()));
      },
    );

    // // Changes state base on the number of players
    // gameRoomSubscription?.onData((gameRoom) {
    //   if (gameRoom.players.length == 2) {
    //     emit(InFullRoomState(gameRoom: gameRoom));
    //   } else if (gameRoom.players.isEmpty) {
    //     emit(const OutsideRoomState());
    //   }
    // });
  }

  /// Searches for an available game room to join.
  ///
  /// If there is an available game room, calls a [JoinRoomEvent] event.
  ///
  /// If there is no available game room, calls a [CreateRoomEvent] event.
  Future<void> _searchGameRoom(
    SearchRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    try {
      // Shows loading.
      emit(const SearchingRoomState());

      // Retrieves all game rooms.
      final List<GameRoom> gameRoomList =
          await _roomRepository.getGameRoomList();

      // Selects only available to join game rooms.
      final List<GameRoom> availableGameRoomList = gameRoomList
          .where((gameRoom) => gameRoom.players.length == 1)
          .toList();

      // If there is an available game room, joins it.
      // Otherwise, creates a new game room.
      if (availableGameRoomList.isEmpty) {
        add(const CreateRoomEvent());
      } else {
        add(JoinRoomEvent(gameRoom: availableGameRoomList.first));
      }
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorRoomState(
        errorTitle: gameRoomError.errorTitle,
        errorText: gameRoomError.errorText,
      ));
    } catch (exception) {
      emit(ErrorRoomState(
        errorText: exception.toString(),
      ));
    }
  }

  /// Creates a new game room and calls [JoinRoomEvent] event.
  Future<void> _createGameRoom(
    CreateRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    try {
      // Probably not needed, but let it be here for a while.
      emit(const LoadingRoomState());

      // Creates game room.
      GameRoom gameRoom = await _roomRepository.createGameRoom();

      // Adds the current user to the game room.
      add(JoinRoomEvent(gameRoom: gameRoom));
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorRoomState(
        errorTitle: gameRoomError.errorTitle,
        errorText: gameRoomError.errorText,
      ));
    } catch (exception) {
      emit(ErrorRoomState(
        errorText: exception.toString(),
      ));
    }
  }

  /// Adds user to the game room and changes the user status to "in the game".
  ///
  /// If the game room is not full, then emits [InRoomState] state.
  /// If the game room is  full, then emits [InFullRoomState] state.
  ///
  /// Throws [GameRoomErrorJoiningRoom] if the room has 0 or more than 2 players.
  Future<void> _joinGameRoom(
    JoinRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    try {
      // Probably not needed, but let it be here for a while.
      emit(const LoadingRoomState());

      GameRoom gameRoom = event.gameRoom;

      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Creates a player to join.
      final Player playerToJoin = Player(
        uid: currentUserAccount.uid,
        username: currentUserAccount.username,
        avatarLink: currentUserAccount.avatarLink,
        chipsCount: {
          Chips.chipSize1: 3,
          Chips.chipSize2: 3,
          Chips.chipSize3: 3,
        },
      );

      // Adds the player to the game room.
      gameRoom = await _roomRepository.addPlayerToGameRoom(
        playerToJoin: playerToJoin,
        gameRoom: gameRoom,
      );

      // Changes the current user account data to show that the user is in a game.
      currentUserAccount = currentUserAccount.copyWith(
        isInGame: true,
        inGameRoomId: gameRoom.uid,
      );

      // Updates the user data according to joining the game room.
      await _accountRepository.updateUserAccount(
        userAccount: currentUserAccount,
      );

      // Shows that the user has to wait for a second player
      // or that the game room is full
      // or throws error in any other case.
      switch (gameRoom.players.length) {
        case 1:
          emit(InRoomState(gameRoom: gameRoom));
          break;
        case 2:
          emit(InFullRoomState(gameRoom: gameRoom));
          break;
        default:
          throw const GameRoomErrorJoiningRoom();
      }
    } on GameRoomError catch (gameRoomError) {
      emit(ErrorRoomState(
        errorTitle: gameRoomError.errorTitle,
        errorText: gameRoomError.errorText,
      ));
    } catch (exception) {
      emit(ErrorRoomState(
        errorText: exception.toString(),
      ));
    }
  }

  /// Removes the current user from the game room and changes the user status to "not in the game".
  ///
  /// If the current user id the last player, then deletes the game room.
  Future<void> _leaveGameRoom(
    LeaveRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    try {
      // Shows loading.
      emit(const LoadingRoomState());

      GameRoom gameRoom = event.gameRoom.copyWith(
        gameRoomState: GameRoomState.result,
      );

      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Removes the current user from the game room.
      gameRoom = await _roomRepository.removePlayerFromGameRoom(
        gameRoom: gameRoom,
        uid: currentUserAccount.uid,
      );

      // Changes the current user account data to show that the user is not in a game.
      currentUserAccount = currentUserAccount.copyWith(
        isInGame: false,
        inGameRoomId: '',
        gamesCount: event.leaveAfterResult
            ? currentUserAccount.gamesCount
            : currentUserAccount.gamesCount + 1,
      );

      // Updates the user data according to leaving the game room.
      await _accountRepository.updateUserAccount(
          userAccount: currentUserAccount);

      // Deletes the game room if there are no player anymore.
      if (gameRoom.players.isEmpty) {
        await _roomRepository.deleteGameRoom(gameRoomId: gameRoom.uid);
      }

      // Indicates that the user has leaved the game and no game screens needed to be shown.
      emit(const OutsideRoomState());
    } catch (exception) {
      emit(const OutsideRoomState());
    }
  }
}

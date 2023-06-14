import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/data/datasources/firestore_game_room_datasource.dart';
import 'package:game/data/models/game_room_model.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/domain/repositories/room_repository.dart';

@immutable
class FirestoreRoomRepository implements RoomRepository {
  final FirestoreGameRoomDatasource _firestoreGameRoomDatasource;

  const FirestoreRoomRepository({
    required FirestoreGameRoomDatasource firestoreGameRoomDatasource,
  }) : _firestoreGameRoomDatasource = firestoreGameRoomDatasource;

  /// Creates a new game room document in the Firestore Database.
  ///
  /// Returns [GameRoom] if a creating process is successful.
  @override
  Future<GameRoom> createGameRoom() async {
    try {
      // Creates a new game room document in the Firestore Database.
      final GameRoomModel gameRoomModel =
          await _firestoreGameRoomDatasource.createGameRoom();

      final GameRoom gameRoom = GameRoom.fromGameRoomModel(
        gameRoomModel: gameRoomModel,
      );

      return gameRoom;
    } catch (exception) {
      rethrow;
    }
  }

  /// Updates a game room data in the Firestore Database.
  @override
  Future<void> updateGameRoom({required GameRoom gameRoom}) async {
    try {
      // Updates a game room data in the Firestore Database.
      await _firestoreGameRoomDatasource.updateGameRoom(
        gameRoomModel: GameRoomModel.fromGameRoomEntity(gameRoom: gameRoom),
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Deletes a game room document from the Firestore Database.
  @override
  Future<void> deleteGameRoom({required String gameRoomId}) async {
    try {
      // Deletes a game room document from the Firestore Database.
      await _firestoreGameRoomDatasource.deleteGameRoom(
        gameRoomId: gameRoomId,
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a game room data from the Firestore Database.
  ///
  /// Returns [GameRoom] if the request was successful.
  @override
  Future<GameRoom> getGameRoom({required String gameRoomId}) async {
    try {
      // Retrieves a game room data from the Firestore Database.
      final GameRoomModel gameRoomModel =
          await _firestoreGameRoomDatasource.getGameRoom(
        gameRoomId: gameRoomId,
      );

      final GameRoom gameRoom = GameRoom.fromGameRoomModel(
        gameRoomModel: gameRoomModel,
      );

      return gameRoom;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a list of data of all game rooms from the Firestore Database.
  ///
  /// Returns a list of [GameRoom] if the request was successful.
  @override
  Future<List<GameRoom>> getGameRoomList() async {
    try {
      // Retrieves a game room list from the Firestore Database.
      final List<GameRoomModel> gameRoomModelList =
          await _firestoreGameRoomDatasource.getGameRoomModelList();

      // Converts the list if needed format.
      final List<GameRoom> gameRoomList =
          gameRoomModelList.map((gameRoomModel) {
        final GameRoom gameRoom = GameRoom.fromGameRoomModel(
          gameRoomModel: gameRoomModel,
        );

        return gameRoom;
      }).toList();

      return gameRoomList;
    } catch (exception) {
      rethrow;
    }
  }

  /// Checks if a game room with specified id exists in the Firestore Database.
  ///
  /// Returns true if the game room exists and false if not.
  ///
  /// Throws [GameRoomErrorEmptyRoom] if the game room is empty.
  @override
  Future<bool> gameRoomExists({required String gameRoomId}) async {
    try {
      // Retrieves a game room document from the Firestore Database.
      final GameRoomModel gameRoomModel =
          await _firestoreGameRoomDatasource.getGameRoom(
        gameRoomId: gameRoomId,
      );

      if (gameRoomModel.players.isEmpty) throw const GameRoomErrorEmptyRoom();

      return true;
    } catch (exception) {
      return false;
    }
  }

  /// Retrieves a stream of game room data changes from the Firestore Dtabase.
  /// 
  /// Returns a stream of [GameRoom] if request was successful.
  @override
  Stream<GameRoom> getGameRoomStream({required String gameRoomId}) {
    try {
      Stream<GameRoomModel> gameRoomModelStream = _firestoreGameRoomDatasource
          .getGameRoomStream(gameRoomId: gameRoomId);

      Stream<GameRoom> gameRoomStream = gameRoomModelStream.map(
        (gameRoomModel) {
          return GameRoom.fromGameRoomModel(gameRoomModel: gameRoomModel);
        },
      );

      return gameRoomStream;
    } catch (exception) {
      rethrow;
    }
  }

  /// Adds a player to the game room, sets a turn of which player is first and 
  /// saves changes in the Firestore Database.
  /// 
  /// Returns [GameRoom] with added player and the first turn of player set.
  /// 
  /// Throws [GameRoomErrorNotAllowedNumberOfPlayers] if there are 2 or more players
  /// in the game room.
  @override
  Future<GameRoom> addPlayerToGameRoom({
    required Player playerToJoin,
    required GameRoom gameRoom,
  }) async {
    try {
      // Checks if a player can be added to the room.
      if (gameRoom.players.length > 1) {
        throw const GameRoomErrorNotAllowedNumberOfPlayers();
      }

      // Adds new player to the list.
      List<Player> playersList = gameRoom.players.toList();
      playersList.add(playerToJoin);

      // Creates an updated game room with a new player.
      final GameRoom gameRoomWithNewPlayer = gameRoom.copyWith(
        players: playersList,
        turnOfPlayerUid: playersList.length == 1
            ? playerToJoin.uid
            : gameRoom.turnOfPlayerUid,
      );

      final GameRoomModel gameRoomModelWithNewPlayer =
          GameRoomModel.fromGameRoomEntity(
        gameRoom: gameRoomWithNewPlayer,
      );

      // Updates an existing game room in the Firestore Database.
      await _firestoreGameRoomDatasource.updateGameRoom(
        gameRoomModel: gameRoomModelWithNewPlayer,
      );

      return gameRoomWithNewPlayer;
    } catch (exception) {
      rethrow;
    }
  }

  /// Removes a player from the game room, sets a player's turn and saves 
  /// changes in the Firestore database.
  /// 
  /// Returns [GameRoom] with removed player and a player's turn set.
  @override
  Future<GameRoom> removePlayerFromGameRoom({
    required String uid,
    required GameRoom gameRoom,
  }) async {
    try {
      // Removes a player from the list.
      final List<Player> players = gameRoom.players.toList();
      players.removeWhere((player) => player.uid == uid);

      final GameRoom gameRoomWithoutPlayer = gameRoom.copyWith(
        players: players,
        turnOfPlayerUid: players.isEmpty ? '' : players.first.uid,
      );

      final GameRoomModel gameRoomModelWithoutPlayer =
          GameRoomModel.fromGameRoomEntity(
        gameRoom: gameRoomWithoutPlayer,
      );

      // Updates an existing game room in the Firestore Database.
      await _firestoreGameRoomDatasource.updateGameRoom(
        gameRoomModel: gameRoomModelWithoutPlayer,
      );

      return gameRoomWithoutPlayer;
    } catch (exception) {
      rethrow;
    }
  }

}

import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/common/errors/game_room_error.dart';

@immutable
abstract class RoomRepository {
  const RoomRepository();

  /// Creates a new game room.
  ///
  /// Returns [GameRoom] if a creating process is successful.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  Future<GameRoom> createGameRoom({required bool private});

  /// Updates a game room data.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  Future<void> updateGameRoom({required GameRoom gameRoom});

  /// Deletes a game room.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  Future<void> deleteGameRoom({required String gameRoomId});

  /// Retrieves a game room data.
  ///
  /// Returns [GameRoom] if the request was successful.
  Future<GameRoom> getGameRoom({required String gameRoomId});

  /// Retrieves a list of data of all game rooms.
  ///
  /// Returns a list of [GameRoom] if the request was successful.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  Future<List<GameRoom>> getGameRoomList();

  /// Checks if a game room with specified id exists.
  ///
  /// Returns true if the game room exists.
  /// 
  /// Deletes the game room if [GameRoomErrorEmptyRoom] occurs.
  /// Returns false if any error occurs.
  Future<bool> gameRoomExists({required String gameRoomId});

  /// Retrieves a stream of game room data changes.
  /// 
  /// Returns a stream of [GameRoom] if request was successful.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  Stream<GameRoom> getGameRoomStream({required String gameRoomId});

  /// Adds a player to the game room and sets a turn of which player is first. 
  /// 
  /// Returns [GameRoom] with added player and a first turn of player set.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  /// Throws [GameRoomErrorNotAllowedNumberOfPlayers] if there are 2 or more players
  /// in the game room.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  Future<GameRoom> addPlayerToGameRoom({
    required Player playerToJoin,
    required GameRoom gameRoom,
  });

  /// Removes a player from the game room, sets a player's turn.
  /// 
  /// Returns [GameRoom] with removed player and a player's turn set.
  /// 
  /// Rethrows [GameRoomError] when the error occurs.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  Future<GameRoom> removePlayerFromGameRoom({
    required String uid,
    required GameRoom gameRoom,
  });

}

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
  Future<GameRoom> createGameRoom();

  /// Updates a game room data.
  Future<void> updateGameRoom({required GameRoom gameRoom});

  /// Deletes a game room.
  Future<void> deleteGameRoom({required String gameRoomId});

  /// Retrieves a game room data.
  ///
  /// Returns [GameRoom] if the request was successful.
  Future<GameRoom> getGameRoom({required String gameRoomId});

  /// Retrieves a list of data of all game rooms.
  ///
  /// Returns a list of [GameRoom] if the request was successful.
  Future<List<GameRoom>> getGameRoomList();

  /// Checks if a game room with specified id exists.
  ///
  /// Returns true if the game room exists and false if not.
  Future<bool> gameRoomExists({required String gameRoomId});

  /// Retrieves a stream of game room data changes.
  /// 
  /// Returns a stream of [GameRoom] if request was successful.
  Stream<GameRoom> getGameRoomStream({required String gameRoomId});

  /// Adds a player to the game room and sets a turn of which player is first. 
  /// 
  /// Returns [GameRoom] with added player and a first turn of player set.
  /// 
  /// Throws [GameRoomErrorNotAllowedNumberOfPlayers] if there are 2 or more players
  /// in the game room.
  Future<GameRoom> addPlayerToGameRoom({
    required Player playerToJoin,
    required GameRoom gameRoom,
  });

  /// Removes a player from the game room, sets a player's turn.
  /// 
  /// Returns [GameRoom] with removed player and a player's turn set.
  Future<GameRoom> removePlayerFromGameRoom({
    required String uid,
    required GameRoom gameRoom,
  });

}

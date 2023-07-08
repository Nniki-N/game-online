import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';

@immutable
abstract class GameRepository {
  const GameRepository();

  /// Checks if a player can make a move.
  ///
  /// Returns true if the move is possible and false if not.
  /// 
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  bool moveIsPossible({
    required List<List<Chip?>> fieldWithChips,
    required Player player,
  });

  /// Replaces player with the same uid in the game room.
  ///
  /// Returns [GameRoom] with replaced player.
  ///
  /// Throws [GameRoomErrorNotFoundPlayer] if the player is not found in the room.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  GameRoom changePlayerDataInGameRoom({
    required GameRoom gameRoom,
    required Player player,
  });


  /// Changes the turn of a player to the next one.
  ///
  /// Return [GameRoom] with the changed turn of a player.
  /// 
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  GameRoom changeTurnForNextPlayer({
    required GameRoom gameRoom,
  });

  /// Returns a uid of a winner if there is a victory combination.
  ///
  /// Returns null if there is no winner.
  /// 
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  String? checkCombinationsAndSelectWinner({
    required List<List<Chip?>> fieldWithChips,
  });
}

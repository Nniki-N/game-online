import 'package:game/common/errors/game_room_error.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/domain/repositories/game_repository.dart';

class IGameRepository implements GameRepository {
  const IGameRepository();

  /// Checks if a player can make a move.
  ///
  /// Returns true if the move is possible and false if not.
  ///
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  @override
  bool moveIsPossible({
    required List<List<Chip?>> fieldWithChips,
    required Player player,
  }) {
    try {
      // Checks if the player has chips at all.
      if (player.chipsCount[Chips.chipSize3]! <= 0 &&
          player.chipsCount[Chips.chipSize2]! <= 0 &&
          player.chipsCount[Chips.chipSize1]! <= 0) {
        return false;
      }

      // Checks if the player can make a move.
      for (int i = 0; i < fieldWithChips.length; i++) {
        for (int j = 0; j < fieldWithChips[i].length; j++) {
          if (fieldWithChips[i][j] == null) return true;

          if (player.chipsCount[Chips.chipSize3]! > 0 &&
              Chips.chipSize3.index > fieldWithChips[i][j]!.chipSize.index &&
              fieldWithChips[i][j]!.chipOfPlayerUid != player.uid) {
            return true;
          }

          if (player.chipsCount[Chips.chipSize2]! > 0 &&
              Chips.chipSize2.index > fieldWithChips[i][j]!.chipSize.index &&
              fieldWithChips[i][j]!.chipOfPlayerUid != player.uid) {
            return true;
          }
        }
      }

      return false;
    } catch (exception) {
      throw GameRoomErrorUnknown(errorText: exception.toString());
    }
  }

  /// Replaces player with the same uid in the game room.
  ///
  /// Returns [GameRoom] with replaced player.
  ///
  /// Throws [GameRoomErrorNotFoundPlayer] if the player is not found in the room.
  /// Throws [GameRoomErrorUnknown] when any other error occurs.
  @override
  GameRoom changePlayerDataInGameRoom({
    required GameRoom gameRoom,
    required Player player,
  }) {
    try {
      List<Player> players = gameRoom.players;

      final int indexOfPlayerInlist =
          players.indexWhere((playerInList) => playerInList.uid == player.uid);

      if (indexOfPlayerInlist == -1) {
        throw const GameRoomErrorNotFoundPlayer();
      }

      players[indexOfPlayerInlist] = player;

      return gameRoom.copyWith(players: players);
    } on GameRoomError {
      rethrow;
    } catch (exception) {
      throw GameRoomErrorUnknown(errorText: exception.toString());
    }
  }

  /// Changes the turn of a player to the next one.
  ///
  /// Return [GameRoom] with the changed turn of a player.
  ///
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  @override
  GameRoom changeTurnForNextPlayer({
    required GameRoom gameRoom,
  }) {
    try {
      // Gets a uid of a next player to play.
      String turnOfCurrentPlayerUid = gameRoom.turnOfPlayerUid;
      final String turnOfNextPlayerUid = gameRoom.players
          .where((playerModel) => playerModel.uid != turnOfCurrentPlayerUid)
          .first
          .uid;

      return gameRoom.copyWith(
        turnOfPlayerUid: turnOfNextPlayerUid,
      );
    } catch (exception) {
      throw GameRoomErrorUnknown(errorText: exception.toString());
    }
  }

  /// Returns a uid of a winner if there is a victory combination.
  ///
  /// Returns null if there is no winner.
  ///
  /// Throws [GameRoomErrorUnknown] when any error occurs.
  @override
  String? checkCombinationsAndSelectWinner({
    required List<List<Chip?>> fieldWithChips,
  }) {
    try {
      // First row.
      if (fieldWithChips[0][0] != null && 
          fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[0][1]?.chipOfPlayerUid &&
          fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[0][2]?.chipOfPlayerUid) {
        return fieldWithChips[0][0]!.chipOfPlayerUid;
      }
      // Second row.
      else if (fieldWithChips[1][0] != null && fieldWithChips[1][0]?.chipOfPlayerUid ==
              fieldWithChips[1][1]?.chipOfPlayerUid &&
          fieldWithChips[1][0]?.chipOfPlayerUid ==
              fieldWithChips[1][2]?.chipOfPlayerUid) {
        return fieldWithChips[1][0]!.chipOfPlayerUid;
      }
      // Third row.
      else if (fieldWithChips[2][0] != null && fieldWithChips[2][0]?.chipOfPlayerUid ==
              fieldWithChips[2][1]?.chipOfPlayerUid &&
          fieldWithChips[2][0]?.chipOfPlayerUid ==
              fieldWithChips[2][2]?.chipOfPlayerUid) {
        return fieldWithChips[2][0]!.chipOfPlayerUid;
      }
      // First column.
      else if (fieldWithChips[0][0] != null && fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[1][0]?.chipOfPlayerUid &&
          fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[2][0]?.chipOfPlayerUid) {
        return fieldWithChips[0][0]!.chipOfPlayerUid;
      }
      // Second column.
      else if (fieldWithChips[0][1] != null && fieldWithChips[0][1]?.chipOfPlayerUid ==
              fieldWithChips[1][1]?.chipOfPlayerUid &&
          fieldWithChips[0][1]?.chipOfPlayerUid ==
              fieldWithChips[2][1]?.chipOfPlayerUid) {
        return fieldWithChips[0][1]!.chipOfPlayerUid;
      }
      // Third column.
      else if (fieldWithChips[0][2] != null && fieldWithChips[0][2]?.chipOfPlayerUid ==
              fieldWithChips[1][2]?.chipOfPlayerUid &&
          fieldWithChips[0][2]?.chipOfPlayerUid ==
              fieldWithChips[2][2]?.chipOfPlayerUid) {
        return fieldWithChips[0][2]!.chipOfPlayerUid;
      }
      // Second diagonal.
      else if (fieldWithChips[0][0] != null && fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[1][1]?.chipOfPlayerUid &&
          fieldWithChips[0][0]?.chipOfPlayerUid ==
              fieldWithChips[2][2]?.chipOfPlayerUid) {
        return fieldWithChips[0][0]!.chipOfPlayerUid;
      }
      // Main diagonal.
      else if (fieldWithChips[0][2] != null && fieldWithChips[0][2]?.chipOfPlayerUid ==
              fieldWithChips[1][1]?.chipOfPlayerUid &&
          fieldWithChips[0][2]?.chipOfPlayerUid ==
              fieldWithChips[2][0]?.chipOfPlayerUid) {
        return fieldWithChips[0][2]!.chipOfPlayerUid;
      }

      return null;
    } catch (exception) {
      throw GameRoomErrorUnknown(errorText: exception.toString());
    }
  }
}

import 'package:game/common/errors/game_room_error.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/domain/repositories/game_repository.dart';

class FirestoreGameRepository implements GameRepository {
  // final FirestoreGameRoomDatasource _firestoreGameRoomDatasource;

  const FirestoreGameRepository(
      // {required FirestoreGameRoomDatasource firestoreGameRoomDatasource,}
      );
  // : _firestoreGameRoomDatasource = firestoreGameRoomDatasource;

  /// Checks if a player can make a move.
  ///
  /// Returns true if the move is possible and false if not.
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
      rethrow;
    }
  }

  /// Replaces player with the same uid in the game room.
  ///
  /// Returns [GameRoom] with replaced player.
  ///
  /// Throws [GameRoomErrorNotFoundPlayer] if the player is not found in the room.
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
    } catch (exception) {
      rethrow;
    }
  }

  /// Changes the turn of a player to the next one.
  ///
  /// Return [GameRoom] with the changed turn of a player.
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

      // final GameRoom updatedGameRoom = gameRoom.copyWith(
      //   turnOfPlayerUid: turnOfNextPlayerUid,
      // );
      //
      // final GameRoomModel updatedGameRoomModel =
      //     GameRoomModel.fromGameRoomEntity(
      //   gameRoom: updatedGameRoom,
      // );
      //
      // // Changes an uid of a player to play in the Firestore Database.
      // await _firestoreGameRoomDatasource.updateGameRoom(
      //   gameRoomModel: updatedGameRoomModel,
      // );
      //
      // return updatedGameRoom;

      return gameRoom.copyWith(
        turnOfPlayerUid: turnOfNextPlayerUid,
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Returns a uid of a winner if there is a victory combination.
  ///
  /// Returns null if there is no winner.
  @override
  String? checkCombinationsAndSelectWinner({
    required List<List<Chip?>> fieldWithChips,
  }) {
    try {
      String? winnerUid;
      const int numberOfChipsNeededForVictory = 3;

      // Checks all victory combinations.
      for (int i = 0; i < fieldWithChips.length; i++) {
        for (var j = 0; j < fieldWithChips[i].length; j++) {
          final String? chipOfPlayerUid = fieldWithChips[i][j]?.chipOfPlayerUid;

          // Checks if a field is empty.
          if (chipOfPlayerUid == null) continue;

          int chipsInLine = 1;

          // Checks chips in a row [i] before [j] index if [j] is greater than 0.
          for (int rowCellIndex = j - 1; rowCellIndex >= 0; rowCellIndex--) {
            if (fieldWithChips[i][rowCellIndex]?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }
          }

          // Checks chips in row [i] after [j] index if [j] is lesser than row lenght.
          for (int rowCellIndex = j + 1;
              rowCellIndex < fieldWithChips[i].length;
              rowCellIndex++) {
            if (fieldWithChips[i][rowCellIndex]?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }
          }

          // Checks if a row combination exists.
          if (chipsInLine >= numberOfChipsNeededForVictory) {
            winnerUid = chipOfPlayerUid;
            break;
          } else {
            chipsInLine = 1;
          }

          // Checks chips in column [j] before [i] index if [i] is greater than 0.
          for (int columnCellIndex = i - 1;
              columnCellIndex >= 0;
              columnCellIndex--) {
            if (fieldWithChips[columnCellIndex][j]?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }
          }

          // Checks chips in column [j] after [i] index if [i] is lesser then column lenght.
          for (int columnCellIndex = i + 1;
              columnCellIndex < fieldWithChips.length;
              columnCellIndex++) {
            if (fieldWithChips[columnCellIndex][j]?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }
          }

          // Checks if a column combination exists.
          if (chipsInLine >= numberOfChipsNeededForVictory) {
            winnerUid = chipOfPlayerUid;
            break;
          } else {
            chipsInLine = 1;
          }

          // Checks chips in main diagonals before [i] and [j] indexes.
          int rowCellIndex = i - 1;
          int collumnCellIndex = j - 1;
          while (rowCellIndex >= 0 && collumnCellIndex >= 0) {
            if (fieldWithChips[rowCellIndex][collumnCellIndex]
                    ?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }

            rowCellIndex--;
            collumnCellIndex--;
          }

          // Checks chips in main diagonals after [i] and [j] indexes.
          rowCellIndex = i + 1;
          collumnCellIndex = j + 1;
          while (rowCellIndex < fieldWithChips.length &&
              collumnCellIndex < fieldWithChips[rowCellIndex].length) {
            if (fieldWithChips[rowCellIndex][collumnCellIndex]
                    ?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }

            rowCellIndex--;
            collumnCellIndex--;
          }

          // Checks if a main diagonal combination exists.
          if (chipsInLine >= numberOfChipsNeededForVictory) {
            winnerUid = chipOfPlayerUid;
            break;
          } else {
            chipsInLine = 1;
          }

          // Checks chips in second diagonals before [i] and after [j] indexes.
          rowCellIndex = i - 1;
          collumnCellIndex = j + 1;
          while (rowCellIndex >= 0 &&
              collumnCellIndex < fieldWithChips[rowCellIndex].length) {
            if (fieldWithChips[rowCellIndex][collumnCellIndex]
                    ?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }

            rowCellIndex--;
            collumnCellIndex++;
          }

          // Checks chips in second diagonals after [i] and before [j] indexes.
          rowCellIndex = i + 1;
          collumnCellIndex = j - 1;
          while (
              rowCellIndex < fieldWithChips.length && collumnCellIndex >= 0) {
            if (fieldWithChips[rowCellIndex][collumnCellIndex]
                    ?.chipOfPlayerUid ==
                chipOfPlayerUid) {
              chipsInLine + 1;
            } else {
              break;
            }

            rowCellIndex++;
            collumnCellIndex--;
          }

          // Checks if a second diagonal combination exists.
          if (chipsInLine >= numberOfChipsNeededForVictory) {
            winnerUid = chipOfPlayerUid;
            break;
          }
        }
      }

      return winnerUid;
    } catch (exception) {
      rethrow;
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:game/data/models/game_room_model.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/player.dart';

/// This entity is used for the main game logic.
/// It contains data about players and fiels.
/// This entity can be converted from [GameRoomModel] model.
class GameRoom {
  final String uid;
  final bool private;
  final List<Player> players;
  final GameRoomState gameRoomState;
  final String winnerUid;
  final String turnOfPlayerUid;
  final List<List<Chip?>> fieldWithChips;

  const GameRoom({
    required this.uid,
    required this.private,
    required this.players,
    required this.gameRoomState,
    required this.winnerUid,
    required this.turnOfPlayerUid,
    required this.fieldWithChips,
  });

  factory GameRoom.fromGameRoomModel({required GameRoomModel gameRoomModel}) =>
      GameRoom(
        uid: gameRoomModel.uid,
        private: gameRoomModel.private,
        players: gameRoomModel.players.map(
          (playerModel) => Player.fromPlayerModel(
            playerModel: playerModel,
          ),
        ).toList(),
        gameRoomState: gameRoomModel.gameRoomState,
        winnerUid: gameRoomModel.winnerUid,
        turnOfPlayerUid: gameRoomModel.turnOfPlayerUid,
        fieldWithChips: gameRoomModel.fieldWithChips.map(
          (chipsList) => chipsList.map(
            (chipModel) => chipModel != null
                ? Chip.fromChipModel(chipModel: chipModel)
                : null,
          ).toList(),
        ).toList(),
      );

  GameRoom copyWith({
    String? uid,
    bool? private,
    List<Player>? players,
    GameRoomState? gameRoomState,
    String? winnerUid,
    String? turnOfPlayerUid,
    List<List<Chip?>>? fieldWithChips,
  }) {
    return GameRoom(
      uid: uid ?? this.uid,
      private: private ?? this.private,
      players: players ?? this.players,
      gameRoomState: gameRoomState ?? this.gameRoomState,
      winnerUid: winnerUid ?? this.winnerUid,
      turnOfPlayerUid: turnOfPlayerUid ?? this.turnOfPlayerUid,
      fieldWithChips: fieldWithChips ?? this.fieldWithChips,
    );
  }
}

enum GameRoomState {
  init,
  inGame,
  result,
}

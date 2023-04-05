import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/game_room_model.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/player.dart';

/// This entity is used for the main game logic.
/// It contains data about players and fiels.
/// This entity can be converted from [GameRoomModel] model.
@immutable
class GameRoom {
  final String uid;
  final Iterable<Player> players;
  final String turnOfPlayerUid;
  final Iterable<Iterable<Chip?>> fieldWithChips;

  const GameRoom({
    required this.uid,
    required this.players,
    required this.turnOfPlayerUid,
    required this.fieldWithChips,
  });

  factory GameRoom.fromGameRoomModel({required GameRoomModel gameRoomModel}) =>
      GameRoom(
        uid: gameRoomModel.uid,
        players: gameRoomModel.players.map(
          (playerModel) => Player.fromPlayerModel(
            playerModel: playerModel,
          ),
        ),
        turnOfPlayerUid: gameRoomModel.turnOfPlayerUid,
        fieldWithChips: gameRoomModel.fieldWithChips.map(
          (chipsList) => chipsList.map(
            (chipModel) => chipModel != null
                ? Chip.fromChipModel(chipModel: chipModel)
                : null,
          ),
        ),
      );
}

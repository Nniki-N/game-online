import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/chip_model.dart';
import 'package:game/data/models/player_model.dart';
import 'package:game/data/models/schemas/game_room_schema.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:game/common/typedefs.dart';

part 'game_room_model.g.dart';

/// This model contains all game data and stores in Firebase.
/// This model can be converted from [GameRoom] entity.
@immutable
@JsonSerializable(explicitToJson: true)
class GameRoomModel {
  @JsonKey(name: GameRoomSchema.uid)
  final String uid;
  @JsonKey(name: GameRoomSchema.players)
  final Iterable<PlayerModel> players;
  @JsonKey(name: GameRoomSchema.turnOfPlayerUid)
  final String turnOfPlayerUid;
  @JsonKey(name: GameRoomSchema.fieldWithChips)
  final Iterable<Iterable<ChipModel?>> fieldWithChips;

  const GameRoomModel({
    required this.uid,
    required this.players,
    required this.turnOfPlayerUid,
    required this.fieldWithChips,
  });

  factory GameRoomModel.fromJson(Json json) => _$GameRoomModelFromJson(json);
  Json toJson() => _$GameRoomModelToJson(this);

  factory GameRoomModel.fromGameRoomEntity({required GameRoom gameRoom}) =>
      GameRoomModel(
        uid: gameRoom.uid,
        players: gameRoom.players.map(
          (playerEntity) => PlayerModel.fromPlayerEntity(player: playerEntity),
        ),
        turnOfPlayerUid: gameRoom.turnOfPlayerUid,
        fieldWithChips: gameRoom.fieldWithChips.map(
          (chipsList) => chipsList.map(
            (chipEntity) => chipEntity != null
                ? ChipModel.fromChipEntity(chip: chipEntity)
                : null,
          ),
        ),
      );
}

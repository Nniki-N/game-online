// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:game/common/utils/game_room_model_convertor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/chip_model.dart';
import 'package:game/data/models/player_model.dart';
import 'package:game/data/models/schemas/game_room_schema.dart';
import 'package:game/domain/entities/game_room.dart';

part 'game_room_model.g.dart';

/// This model contains all game data and stores in Firebase.
/// This model can be converted from [GameRoom] entity.
@JsonSerializable(explicitToJson: true)
class GameRoomModel {
  @JsonKey(name: GameRoomSchema.uid)
  final String uid;
  @JsonKey(name: GameRoomSchema.private)
  final bool private;
  @JsonKey(name: GameRoomSchema.players)
  final List<PlayerModel> players;
  @JsonKey(name: GameRoomSchema.gameRoomState)
  final GameRoomState gameRoomState;
  @JsonKey(name: GameRoomSchema.winnerUid)
  final String winnerUid;
  @JsonKey(name: GameRoomSchema.turnOfPlayerUid)
  final String turnOfPlayerUid;
  @JsonKey(
    name: GameRoomSchema.fieldWithChips,
    toJson: fieldWithChipsToJson,
    fromJson: fieldWithChipsFromJson,
  )
  final List<List<ChipModel?>> fieldWithChips;

  const GameRoomModel({
    required this.uid,
    required this.private,
    required this.players,
    required this.gameRoomState,
    required this.winnerUid,
    required this.turnOfPlayerUid,
    required this.fieldWithChips,
  });

  factory GameRoomModel.fromJson(Json json) => _$GameRoomModelFromJson(json);
  Json toJson() => _$GameRoomModelToJson(this);

  factory GameRoomModel.fromGameRoomEntity({required GameRoom gameRoom}) =>
      GameRoomModel(
        uid: gameRoom.uid,
        private: gameRoom.private,
        players: gameRoom.players
            .map(
              (playerEntity) =>
                  PlayerModel.fromPlayerEntity(player: playerEntity),
            )
            .toList(),
        gameRoomState: gameRoom.gameRoomState,
        winnerUid: gameRoom.winnerUid,
        turnOfPlayerUid: gameRoom.turnOfPlayerUid,
        fieldWithChips: gameRoom.fieldWithChips
            .map(
              (chipsList) => chipsList
                  .map(
                    (chipEntity) => chipEntity != null
                        ? ChipModel.fromChipEntity(chip: chipEntity)
                        : null,
                  )
                  .toList(),
            )
            .toList(),
      );

  GameRoomModel copyWith({
    String? uid,
    bool? private,
    List<PlayerModel>? players,
    GameRoomState? gameRoomState,
    String? winnerUid,
    String? turnOfPlayerUid,
    List<List<ChipModel?>>? fieldWithChips,
  }) {
    return GameRoomModel(
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

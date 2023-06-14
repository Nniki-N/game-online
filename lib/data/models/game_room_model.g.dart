// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRoomModel _$GameRoomModelFromJson(Map<String, dynamic> json) =>
    GameRoomModel(
      uid: json['uid'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameRoomState: $enumDecode(_$GameRoomStateEnumMap, json['gameRoomState']),
      winnerUid: json['winnerUid'] as String,
      turnOfPlayerUid: json['turnOfPlayerUid'] as String,
      fieldWithChips: (json['fieldwithChips'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => e == null
                  ? null
                  : ChipModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$GameRoomModelToJson(GameRoomModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'gameRoomState': _$GameRoomStateEnumMap[instance.gameRoomState]!,
      'winnerUid': instance.winnerUid,
      'turnOfPlayerUid': instance.turnOfPlayerUid,
      'fieldwithChips': instance.fieldWithChips
          .map((e) => e.map((e) => e?.toJson()).toList())
          .toList(),
    };

const _$GameRoomStateEnumMap = {
  GameRoomState.init: 'init',
  GameRoomState.inGame: 'inGame',
  GameRoomState.result: 'result',
};

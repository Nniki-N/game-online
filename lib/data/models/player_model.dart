// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/player_schema.dart';
import 'package:game/domain/entities/chip.dart' show Chips;
import 'package:game/domain/entities/player.dart';

part 'player_model.g.dart';

/// This model is stored in Firebase
/// This model can be converted from [Player] entity.
@JsonSerializable(explicitToJson: true)
class PlayerModel {
  @JsonKey(name: PlayerSchema.uid)
  final String uid;
  @JsonKey(name: PlayerSchema.username)
  final String username;
  @JsonKey(name: PlayerSchema.avatarLink)
  final String? avatarLink;
  @JsonKey(name: PlayerSchema.chipsCount)
  final Map<Chips, int> chipsCount;

  const PlayerModel({
    required this.uid,
    required this.username,
    required this.avatarLink,
    required this.chipsCount,
  });

  factory PlayerModel.fromJson(Json json) => _$PlayerModelFromJson(json);
  Json toJson() => _$PlayerModelToJson(this);

  factory PlayerModel.fromPlayerEntity({required Player player}) => PlayerModel(
        uid: player.uid,
        username: player.username,
        avatarLink: player.avatarLink,
        chipsCount: player.chipsCount,
      );

  PlayerModel copyWith({
    String? uid,
    String? username,
    String? avatarLink,
    Map<Chips, int>? chipsCount,
  }) {
    return PlayerModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarLink: avatarLink ?? this.avatarLink,
      chipsCount: chipsCount ?? this.chipsCount,
    );
  }
}

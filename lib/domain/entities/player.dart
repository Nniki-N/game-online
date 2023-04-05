import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/player_model.dart';
import 'package:game/domain/entities/chip.dart';

/// This entity contains data about user in the game, like usernaem,
/// avatar link, number of chips
/// This entity can be converted from [PlayerModel] model.
@immutable
class Player {
  final String uid;
  final String username;
  final String avatarLink;
  final Map<Chips, int> chipsCount;

  const Player({
    required this.uid,
    required this.username,
    required this.avatarLink,
    required this.chipsCount,
  });

  factory Player.fromPlayerModel({required PlayerModel playerModel}) => Player(
        uid: playerModel.uid,
        username: playerModel.username,
        avatarLink: playerModel.avatarLink,
        chipsCount: playerModel.chipsCount,
      );
}

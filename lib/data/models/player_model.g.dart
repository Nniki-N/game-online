// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => PlayerModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      avatarLink: json['avatarLink'] as String,
      chipsCount: (json['chipsCount'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$ChipsEnumMap, k), e as int),
      ),
    );

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'avatarLink': instance.avatarLink,
      'chipsCount':
          instance.chipsCount.map((k, e) => MapEntry(_$ChipsEnumMap[k]!, e)),
    };

const _$ChipsEnumMap = {
  Chips.chipSize1: 'chipSize1',
  Chips.chipSize2: 'chipSize2',
  Chips.chipSize3: 'chipSize3',
};

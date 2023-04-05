// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChipModel _$ChipModelFromJson(Map<String, dynamic> json) => ChipModel(
      chipSize: $enumDecode(_$ChipsEnumMap, json['chipSize']),
      chipOfPlayerUid: json['chipOfPlayerUid'] as String,
    );

Map<String, dynamic> _$ChipModelToJson(ChipModel instance) => <String, dynamic>{
      'chipSize': _$ChipsEnumMap[instance.chipSize]!,
      'chipOfPlayerUid': instance.chipOfPlayerUid,
    };

const _$ChipsEnumMap = {
  Chips.chipSize1: 'chipSize1',
  Chips.chipSize2: 'chipSize2',
  Chips.chipSize3: 'chipSize3',
};

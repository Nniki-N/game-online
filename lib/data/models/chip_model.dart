// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/schemas/chip_schema.dart';
import 'package:game/domain/entities/chip.dart';

part 'chip_model.g.dart';

/// This model is stored in Firebase
/// This model can be converted from [Chip] entity.
@JsonSerializable(explicitToJson: true)
class ChipModel {
  @JsonKey(name: ChipSchema.chipSize)
  final Chips chipSize;
  @JsonKey(name: ChipSchema.chipOfPlayerUid)
  final String chipOfPlayerUid;

  const ChipModel({
    required this.chipSize,
    required this.chipOfPlayerUid,
  });

  factory ChipModel.fromJson(Json json) => _$ChipModelFromJson(json);
  Json toJson() => _$ChipModelToJson(this);

  factory ChipModel.fromChipEntity({required Chip chip}) => ChipModel(
        chipSize: chip.chipSize,
        chipOfPlayerUid: chip.chipOfPlayerUid,
      );

  ChipModel copyWith({
    Chips? chipSize,
    String? chipOfPlayerUid,
  }) {
    return ChipModel(
      chipSize: chipSize ?? this.chipSize,
      chipOfPlayerUid: chipOfPlayerUid ?? this.chipOfPlayerUid,
    );
  }
}

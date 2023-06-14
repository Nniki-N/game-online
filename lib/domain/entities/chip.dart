// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:game/data/models/chip_model.dart';

/// This entity represent different chips and who possess them
/// This entity can be converted from [ChipModel] model.
class Chip {
  final Chips chipSize;
  final String chipOfPlayerUid;

  const Chip({
    required this.chipSize,
    required this.chipOfPlayerUid,
  });

  factory Chip.fromChipModel({required ChipModel chipModel}) => Chip(
        chipSize: chipModel.chipSize,
        chipOfPlayerUid: chipModel.chipOfPlayerUid,
      );

  Chip copyWith({
    Chips? chipSize,
    String? chipOfPlayerUid,
  }) {
    return Chip(
      chipSize: chipSize ?? this.chipSize,
      chipOfPlayerUid: chipOfPlayerUid ?? this.chipOfPlayerUid,
    );
  }
}

enum Chips {
  chipSize1,
  chipSize2,
  chipSize3,
}

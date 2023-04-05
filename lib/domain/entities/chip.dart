import 'package:flutter/foundation.dart' show immutable;
import 'package:game/data/models/chip_model.dart';

/// This entity represent different chips and who possess them
/// This entity can be converted from [ChipModel] model.
@immutable
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
}

enum Chips {
  chipSize1,
  chipSize2,
  chipSize3,
}

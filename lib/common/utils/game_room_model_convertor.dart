import 'dart:convert';

import 'package:game/common/typedefs.dart';
import 'package:game/data/models/chip_model.dart';

String fieldWithChipsToJson(List<List<ChipModel?>> fieldWithChips) {
  final String jsonFieldWithChips = jsonEncode(fieldWithChips.map<List<Json?>>(
    (row) {
      return row.map<Json?>(
        (chipModel) {
          return chipModel?.toJson();
        },
      ).toList();
    },
  ).toList());

  return jsonFieldWithChips;
}

List<List<ChipModel?>> fieldWithChipsFromJson(String fieldWithChipsJson) {
  List<List<ChipModel?>> fieldWithChips = (jsonDecode(fieldWithChipsJson) as List<dynamic>).map<List<ChipModel?>>(
    (row) {
      return (row as List<dynamic>).map<ChipModel?>(
        (json) {
          return json == null ? null : ChipModel.fromJson(json);
        },
      ).toList();
    },
  ).toList();

  return fieldWithChips;
}

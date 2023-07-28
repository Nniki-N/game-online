import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/language.dart';

@immutable
class LanguageState {
  final Language language;

  const LanguageState({
    Language? language,
  }) : language = language ?? Language.english;
}

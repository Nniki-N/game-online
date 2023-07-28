import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/language.dart';

@immutable
abstract class LanguageRepository {
  const LanguageRepository();

  /// Saves [Language] in the local storage.
  Future<void> saveLanguage({required Language language});

  /// Retrieves [Language] from the local storage.
  ///
  /// Returns [Language.english] if nothing is saved in the local storage.
  Future<Language> get language;
}

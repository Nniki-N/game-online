
import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/constants/language_constants.dart';
import 'package:game/domain/entities/language.dart';
import 'package:game/domain/repositories/language_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class PreferencesLanguageRepository implements LanguageRepository {
  final Logger _logger;

  const PreferencesLanguageRepository({
    required Logger logger,
  }) : _logger = logger;

  /// Saves [Language] in the shared preferences.
  @override
  Future<void> saveLanguage({required Language language}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Saves a language code in the shared preferences.
      await prefs.setString(
        LanguageConstants.localeLanguageCodeKey,
        language.locale.languageCode,
      );
    } catch (exception) {
      _logger.e(exception);
    }
  }

  /// Retrieves [Language] from the shared preferences.
  ///
  /// Returns [Language.english] if nothing is saved in the shared preferences.
  @override
  Future<Language> get language async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieves a language code from the shared preferences.
      final String? languageCode = prefs.getString(
        LanguageConstants.localeLanguageCodeKey,
      );

      // If nothing is saved in the shared preferences, saves english as a default language.
      if (languageCode == null) {
        saveLanguage(language: Language.english);
      }

      // Selects a language.
      final Language language = Language.values.firstWhere(
        (language) => language.locale.languageCode == languageCode,
        orElse: () => Language.english,
      );

      return language;
    } catch (exception) {
      _logger.e(exception);
      return Language.english;
    }
  }
}

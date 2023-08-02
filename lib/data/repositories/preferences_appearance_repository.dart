import 'package:flutter/foundation.dart';
import 'package:game/common/constants/shared_preferences_constants.dart';
import 'package:game/domain/repositories/appearance_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class PreferencesAppearanceRepository extends AppearanceRepository {
  final Logger _logger;

  const PreferencesAppearanceRepository({
    required Logger logger,
  }) : _logger = logger;

  /// Saves [isDark] in the shared preferences.
  @override
  Future<void> saveAppearanceMode({required bool isDark}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Saves an appearance mode in the shared preferences.
      await prefs.setBool(
        PreferencesConstants.appearanceModeKey,
        isDark,
      );
    } catch (exception) {
      _logger.e(exception);
    }
  }

  /// Saves [isAutomatic] in the shared preferences.
  @override
  Future<void> saveAutomaticAppearanceMode({required bool isAutomatic}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Saves an automatic appearance mode in the shared preferences.
      await prefs.setBool(
        PreferencesConstants.automaticAppearanceModeKey,
        isAutomatic,
      );
    } catch (exception) {
      _logger.e(exception);
    }
  }

  /// Retrieves an appearance mode from the shared preferences.
  ///
  /// Returns false if nothing is saved in the shared preferences.
  @override
  Future<bool> get appearanceIsDark async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieves an appearance mode from the shared preferences.
      final bool? isDark = prefs.getBool(
        PreferencesConstants.appearanceModeKey,
      );

      return isDark ?? false;
    } catch (exception) {
      _logger.e(exception);
      return false;
    }
  }

  /// Retrieves an automatic appearance mode from the shared preferences.
  ///
  /// Returns false if nothing is saved in the shared preferences.
  @override
  Future<bool> get appearanceIsAutomatic async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieves an automatic appearance mode from the shared preferences.
      final bool? isAutomatic = prefs.getBool(
        PreferencesConstants.automaticAppearanceModeKey,
      );

      return isAutomatic ?? false;
    } catch (exception) {
      _logger.e(exception);
      return false;
    }
  }
}

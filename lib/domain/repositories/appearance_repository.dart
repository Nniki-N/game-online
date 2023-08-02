import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppearanceRepository {
  const AppearanceRepository();

  /// Saves [isDark] in the local storage.
  Future<void> saveAppearanceMode({required bool isDark});

  /// Saves [isAutomatic] in the local storage.
  Future<void> saveAutomaticAppearanceMode({required bool isAutomatic});

  /// Retrieves an appearance mode from the local storage.
  ///
  /// Returns false if nothing is saved in the local storage.
  Future<bool> get appearanceIsDark;

  /// Retrieves an automatic appearance mode from the local storage.
  ///
  /// Returns false if nothing is saved in the local storage.
  Future<bool> get appearanceIsAutomatic;
}

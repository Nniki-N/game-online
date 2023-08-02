import 'package:flutter/foundation.dart';

@immutable
abstract class AppearanceState {
  const AppearanceState();
}

@immutable
class InitialAppearanceState extends AppearanceState {
  const InitialAppearanceState();
}

@immutable
class LoadedAppearanceState extends AppearanceState {
  final bool isAutomatic;
  final bool isDark;

  const LoadedAppearanceState({
    required this.isAutomatic,
    required this.isDark,
  });
}

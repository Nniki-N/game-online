import 'package:flutter/foundation.dart';

@immutable
abstract class AppearanceEvent {
  const AppearanceEvent();
}

@immutable
class InitializeAppearanceEvent extends AppearanceEvent {
  const InitializeAppearanceEvent();
}

@immutable
class ChangeAppearanceEvent extends AppearanceEvent {
  final bool isDark;

  const ChangeAppearanceEvent({
    required this.isDark,
  });
}

@immutable
class SetAutomaticAppearanceEvent extends AppearanceEvent {
  final bool isAutomatic;

  const SetAutomaticAppearanceEvent({
    required this.isAutomatic,
  });
}

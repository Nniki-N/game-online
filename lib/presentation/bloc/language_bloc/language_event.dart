import 'package:flutter/foundation.dart' show immutable;
import 'package:game/domain/entities/language.dart';

@immutable
abstract class LanguageEvent {
  const LanguageEvent();
}

@immutable
class InitializeLanguageEvent extends LanguageEvent {
  const InitializeLanguageEvent();
}

@immutable
class ChangeLanguageEvent extends LanguageEvent {
  final Language language;

  const ChangeLanguageEvent({
    required this.language,
  });
}

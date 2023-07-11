import 'package:flutter/foundation.dart';

@immutable
abstract class FormValidationEvent {
  final bool lastValidation;

  const FormValidationEvent({
    required this.lastValidation,
  });
}

@immutable
class EmailFormValidationEvent extends FormValidationEvent {
  final String? email;
  final String validationEmptyEmail;
  final String validationIncorrectEmail;

  const EmailFormValidationEvent({
    bool lastValidation = false,
    required this.email,
    required this.validationEmptyEmail,
    required this.validationIncorrectEmail,
  }): super(lastValidation: lastValidation);
}

@immutable
class TextFormValidationEvent extends FormValidationEvent {
  final String? text;
  final int minSymbols;
  final int maxSymbols;
  final List<String> forbiddenSymbols;
  final String validationForbiddenSymbolsText;
  final String validationEmptyText;
  final String validationToManySymbolsText;
  final String validationNotEnoughtSymbolsText;

  const TextFormValidationEvent({
    bool lastValidation = false,
    required this.text,
    this.minSymbols = 3,
    this.maxSymbols = 55,
    this.forbiddenSymbols = const [],
    required this.validationForbiddenSymbolsText,
    required this.validationEmptyText,
    required this.validationToManySymbolsText,
    required this.validationNotEnoughtSymbolsText,
  }): super(lastValidation: lastValidation);
}

@immutable
class SimilarityTextFormValidationEvent extends FormValidationEvent {
  final List<String> texts;
  final String validationFailureText;

  const SimilarityTextFormValidationEvent({
    bool lastValidation = false,
    required this.texts,
    required this.validationFailureText,
  }): super(lastValidation: lastValidation);
}

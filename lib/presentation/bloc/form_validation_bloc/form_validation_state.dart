import 'package:flutter/foundation.dart';

@immutable
abstract class FormValidationState {
  final bool validationFinished;

  const FormValidationState({
    required this.validationFinished,
  });
}

@immutable
class InitialFormValidationState extends FormValidationState {
  const InitialFormValidationState({
    bool validationFinished = false,
  }) : super(validationFinished: validationFinished);
}

@immutable
class ValidatedFormValidationState extends FormValidationState {
  const ValidatedFormValidationState({
    bool validationFinished = false,
  }) : super(validationFinished: validationFinished);
}

@immutable
class FailedFormValidationState extends FormValidationState {
  final List<String> validationMessages;

  const FailedFormValidationState({
    bool validationFinished = false,
    required this.validationMessages,
  }) : super(validationFinished: validationFinished);
}

extension GetValidationMessages on FormValidationState {
  List<String> getValidationMessages() {
    final FormValidationState state = this;

    if (state is FailedFormValidationState) {
      return state.validationMessages;
    } else {
      return [];
    }
  }
}

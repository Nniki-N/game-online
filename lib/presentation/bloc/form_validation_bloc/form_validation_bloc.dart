import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(const InitialFormValidationState()) {
    on<EmailFormValidationEvent>(_emailValidation);
    on<TextFormValidationEvent>(_textValidation);
    on<SimilarityTextFormValidationEvent>(_similarityTextValidation);
  }

  /// Validates email address.
  ///
  /// Emits [FailedFormValidationState] if an email address is emty or incorrect.
  /// Emits [ValidatedFormValidationState] if a validation was successful.
  Future<void> _emailValidation(
    EmailFormValidationEvent event,
    Emitter<FormValidationState> emit,
  ) async {
    // Checks if it is a new validation.
    _checkForNewValidation(emit: emit);

    final String? email = event.email;

    // Checks if an email address is empty.
    if (email == null || email.trim().isEmpty) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationEmptyEmail,
        validationFinished: event.lastValidation,
      );
      return;
    }

    // Checks if an email address if incorrect.
    final bool emailValid = EmailValidator.validate(email, true);

    if (emailValid &&
        event.lastValidation &&
        state is! FailedFormValidationState) {
      // Indicates that the validation was successful.
      emit(const ValidatedFormValidationState(validationFinished: true));
    } else if (!emailValid) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationEmptyEmail,
        validationFinished: event.lastValidation,
      );
    } else if (event.lastValidation && state is FailedFormValidationState) {
      emit(FailedFormValidationState(
        validationMessages: state.getValidationMessages(),
        validationFinished: true,
      ));
    }
  }

  /// Validates a text.
  ///
  /// Emits [FailedFormValidationState] if a text is emty or incorrect or out of size restrictions.
  /// Emits [ValidatedFormValidationState] if a validation was successful.
  Future<void> _textValidation(
    TextFormValidationEvent event,
    Emitter<FormValidationState> emit,
  ) async {
    // Checks if it is a new validation.
    _checkForNewValidation(emit: emit);

    final String? text = event.text;

    // Checks if a text is empty.
    if (text == null || text.trim().isEmpty) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationEmptyText,
        validationFinished: event.lastValidation,
      );
      return;
    }

    // Checks if a text is out of size restrictions.
    if (text.length < event.minSymbols) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationNotEnoughtSymbolsText,
        validationFinished: event.lastValidation,
      );
      return;
    } else if (text.length > event.maxSymbols) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationToManySymbolsText,
        validationFinished: event.lastValidation,
      );
      return;
    }

    bool hasForbiddenSymbols = false;

    // Checks if a text contains forbidden symbols.
    for (String symbol in event.forbiddenSymbols) {
      if (text.contains(symbol)) {
        hasForbiddenSymbols = true;
        break;
      }
    }

    if (hasForbiddenSymbols) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationForbiddenSymbolsText,
        validationFinished: event.lastValidation,
      );
    } else if (event.lastValidation && state is! FailedFormValidationState) {
      // Indicates that the validation was successful.
      emit(const ValidatedFormValidationState(validationFinished: true));
    } else if (event.lastValidation && state is FailedFormValidationState) {
      emit(FailedFormValidationState(
        validationMessages: state.getValidationMessages(),
        validationFinished: true,
      ));
    }
  }

  /// Validates text by comparing them.
  ///
  /// Emits [FailedFormValidationState] if texts are not similar.
  /// Emits [ValidatedFormValidationState] if a validation was successful.
  Future<void> _similarityTextValidation(
    SimilarityTextFormValidationEvent event,
    Emitter<FormValidationState> emit,
  ) async {
    // Checks if it is a new validation.
    _checkForNewValidation(emit: emit);

    // Checks if there are no texts.
    final List<String> texts = event.texts;
    if (texts.isEmpty) return;

    final String firstText = texts.first;
    bool textsAreSimilar = true;

    // Checks if all texts are similar.
    for (String text in texts) {
      if (firstText != text) {
        textsAreSimilar = false;
        break;
      }
    }

    if (textsAreSimilar &&
        event.lastValidation &&
        state is! FailedFormValidationState) {
      // Indicates that the validation was successful.
      emit(const ValidatedFormValidationState(validationFinished: true));
    } else if (!textsAreSimilar) {
      _emitFailedState(
        emit: emit,
        validationMessage: event.validationFailureText,
        validationFinished: event.lastValidation,
      );
    } else if (event.lastValidation && state is FailedFormValidationState) {
      emit(FailedFormValidationState(
        validationMessages: state.getValidationMessages(),
        validationFinished: true,
      ));
    }
  }

  /// Emits [FailedFormValidationState] with additional message and finish status.
  void _emitFailedState({
    required Emitter<FormValidationState> emit,
    required String validationMessage,
    required bool validationFinished,
  }) {
    // Adds hints to the validation response.
    List<String> validationMessages = state.getValidationMessages()
      ..add(validationMessage);

    // Indicates that the validation failed.
    emit(FailedFormValidationState(
      validationMessages: validationMessages,
      validationFinished: validationFinished,
    ));
  }

  /// Emits [InitialFormValidationState] if a validation was already made.
  void _checkForNewValidation({required Emitter<FormValidationState> emit}) {
    // Last validation failed.
    if (state is FailedFormValidationState && state.validationFinished) {
      emit(const InitialFormValidationState());
    }
    // Last validation was successful.
    else if (state is ValidatedFormValidationState &&
        state.validationFinished) {
      emit(const InitialFormValidationState());
    }
  }
}

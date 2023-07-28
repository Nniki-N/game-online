import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/domain/entities/language.dart';
import 'package:game/domain/repositories/language_repository.dart';
import 'package:game/presentation/bloc/language_bloc/language_event.dart';
import 'package:game/presentation/bloc/language_bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _languageRepository;

  LanguageBloc({required LanguageRepository languageRepository})
      : _languageRepository = languageRepository,
        super(const LanguageState()) {
    on<InitializeLanguageEvent>(_init);
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  /// Initializes language.
  Future<void> _init(
    InitializeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    log('start language initialize');
    // Retrieves a language.
    final Language language = await _languageRepository.language;

    // Indicates that initialization ended.
    emit(LanguageState(language: language));
  }

  /// Changes language.
  Future<void> _changeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await _languageRepository.saveLanguage(language: event.language);

    // Indicates that language was changed.
    emit(LanguageState(language: event.language));
  }
}

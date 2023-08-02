import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/domain/repositories/appearance_repository.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_event.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_state.dart';

class AppearanceBloc extends Bloc<AppearanceEvent, AppearanceState> {
  final AppearanceRepository _appearanceRepository;

  AppearanceBloc({
    required AppearanceRepository appearanceRepository,
  })  : _appearanceRepository = appearanceRepository,
        super(const InitialAppearanceState()) {
    on<InitializeAppearanceEvent>(_init);
    on<ChangeAppearanceEvent>(_changeAppearanceMode);
    on<SetAutomaticAppearanceEvent>(_setAutomaticMode);
  }

  /// Initializes appearance.
  Future<void> _init(
    InitializeAppearanceEvent event,
    Emitter<AppearanceState> emit,
  ) async {
    log('initialize appearance theme');

    // Retrieves an automatic appearance mode and an appearance mode.
    final bool isAutomatic = await _appearanceRepository.appearanceIsAutomatic;
    final bool isDark = await _appearanceRepository.appearanceIsDark;

    // Indicates that appearance was initialized.
    emit(LoadedAppearanceState(
      isDark: isDark,
      isAutomatic: isAutomatic,
    ));
  }

  /// Change appearance mode.
  Future<void> _changeAppearanceMode(
    ChangeAppearanceEvent event,
    Emitter<AppearanceState> emit,
  ) async {
    await _appearanceRepository.saveAppearanceMode(isDark: event.isDark);

    // Indicates that appearance mode was changed.
    emit(LoadedAppearanceState(
      isDark: event.isDark,
      isAutomatic: (state as LoadedAppearanceState).isAutomatic,
    ));
  }

  /// Change automatic appearance mode.
  Future<void> _setAutomaticMode(
    SetAutomaticAppearanceEvent event,
    Emitter<AppearanceState> emit,
  ) async {
    await _appearanceRepository.saveAutomaticAppearanceMode(
      isAutomatic: event.isAutomatic,
    );

    // Indicates that automatic appearance mode was changed.
    emit(LoadedAppearanceState(
      isDark: (state as LoadedAppearanceState).isDark,
      isAutomatic: event.isAutomatic,
    ));
  }
}

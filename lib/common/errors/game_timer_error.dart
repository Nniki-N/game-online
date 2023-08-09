
import 'package:flutter/foundation.dart';

/// The abstract error for a game timer exeption.
@immutable
abstract class GameTimerError {
  final String errorTitle;
  final String errorText;

  const GameTimerError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [GameTimerError] child for an unknown error.
@immutable
class GameTimerErrorUnknown extends GameTimerError {
  const GameTimerErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown game timer error happened',
        );
}

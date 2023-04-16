import 'package:flutter/widgets.dart' show immutable;

typedef UpdateLoadingOverlay = bool Function(String text);
typedef HideLoadingOverlay = bool Function();

@immutable
class LoadingOverlayController {
  final UpdateLoadingOverlay update;
  final HideLoadingOverlay hide;

  const LoadingOverlayController({
    required this.update,
    required this.hide,
  });
}

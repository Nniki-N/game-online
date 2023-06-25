import 'package:flutter/widgets.dart' show immutable;

typedef UpdateLoadingOverlay = bool Function(String? title, String? text);
typedef HideLoadingOverlay = bool Function();

/// A controller of a custom loading overlay.
/// 
/// [update] is a method that updates overlay. A title and a text can be 
/// transfrered within.
/// 
/// [hide] is a method that hides overlay.
@immutable
class LoadingOverlayController {
  final UpdateLoadingOverlay update;
  final HideLoadingOverlay hide;

  const LoadingOverlayController({
    required this.update,
    required this.hide,
  });
}

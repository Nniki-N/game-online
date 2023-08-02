import 'dart:async';

import 'package:flutter/material.dart' hide IconTheme, TextTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/popup_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/presentation/widgets/loading_overlay/loading_overlay_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// A custom fullscreen overlay.
///
/// [loadingOverlayController] is a overlay controller that is set when the method
/// [show] is called and equals null when the method [hide] is called.
class LoadingOverlay {
  LoadingOverlay._sharedInstance();
  static final LoadingOverlay _shared = LoadingOverlay._sharedInstance();
  factory LoadingOverlay.instance() => _shared;

  LoadingOverlayController? loadingOverlayController;

  /// Updates an already created overlay or shows a new overlay.
  void show({
    required BuildContext context,
    required String? title,
    required String? text,
  }) {
    if (loadingOverlayController?.update(title, text) ?? false) {
      return;
    } else {
      loadingOverlayController = _showOverlay(
        context: context,
        title: title,
        text: text,
      );
    }
  }

  /// Hides overlay if it is shown and sets controller as a null.
  void hide() {
    loadingOverlayController?.hide();
    loadingOverlayController = null;
  }

  /// Creates a new overlay and returns [LoadingOverlayController] of this overlay.
  LoadingOverlayController _showOverlay({
    required BuildContext context,
    required String? title,
    required String? text,
  }) {
    // This stream is used to update the overlay.
    final StreamController<Map<String, String?>> textAndTitleStreamController =
        StreamController<Map<String, String?>>();

    // Adds first data to the stream that will be show in the overlay.
    textAndTitleStreamController.add({
      'title': title,
      'text': text,
    });

    // Gets available size to show overlay.
    final OverlayState state = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;
    final PopUpTheme popUpTheme =
        Theme.of(context).extension<PopUpTheme>()!;

    // Creates overlay.
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: popUpTheme.overlayColor,
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.all(30.w),
            color: backgroundTheme.color,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading widget.
                LoadingAnimationWidget.hexagonDots(
                  color: iconTheme.color2,
                  size: 100.w,
                ),
                const SizedBox(height: 20),
                // Builds and updates data base on the textAndTitleStreamController stream.
                StreamBuilder(
                  stream: textAndTitleStreamController.stream,
                  builder: (context, snapshot) {
                    // Shows a content if there is data in the stream update.
                    if (snapshot.hasData) {
                      final String? snapshotTitle =
                          (snapshot.data as Map<String, String?>)['title'];

                      final String? snapshotText =
                          (snapshot.data as Map<String, String?>)['text'];

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // The title.
                          snapshotTitle == null
                              ? const SizedBox.shrink()
                              : CustomText(
                                  text: snapshotTitle,
                                  textAlign: TextAlign.center,
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                          // Space between the title and the text content.
                          snapshotTitle != null && snapshotText != null
                              ? SizedBox(height: 5.h)
                              : const SizedBox.shrink(),
                          // The text content.
                          snapshotText == null
                              ? const SizedBox.shrink()
                              : CustomText(
                                  text: snapshotText,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w400,
                                  color: textTheme.color3,
                                ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    // Shows the overlay on the screen.
    state.insert(overlay);

    // Returns a controller of the overlay with defined update and hide methods.
    return LoadingOverlayController(
      update: (title, text) {
        textAndTitleStreamController.add({
          'title': title,
          'text': text,
        });
        return true;
      },
      hide: () {
        textAndTitleStreamController.close();
        overlay.remove();
        return true;
      },
    );
  }
}

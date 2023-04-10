import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/presentation/widgets/loading_overlay_controller.dart';

class LoadingOverlay {
  LoadingOverlay._sharedInstance();
  static final LoadingOverlay _shared = LoadingOverlay._sharedInstance();
  factory LoadingOverlay.instance() => _shared;

  LoadingOverlayController? loadingOverlayController;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (loadingOverlayController?.update(text) ?? false) {
      return;
    } else {
      loadingOverlayController = _showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    loadingOverlayController?.hide();
    loadingOverlayController = null;
  }

  LoadingOverlayController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final StreamController<String> textStreamController =
        StreamController<String>();
    textStreamController.add(text);

    final OverlayState state = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.25,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data as String,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingOverlayController(
      update: (text) {
        textStreamController.add(text);
        return true;
      },
      hide: () {
        textStreamController.close();
        overlay.remove();
        return true;
      },
    );
  }
}

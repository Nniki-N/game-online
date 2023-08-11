import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/popup_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

typedef DialogOptionsBuilder<T> = Map<String, T?> Function();

/// A custom basic method to show dialog popup.
///
/// [popUpTitle] is a text that is shown as a title of a dialog popup.
///
/// [popUpText] is a text that is shown as a text of a dialog popup.
///
/// [dialogOptionsBuilder] is a map of names of buttons and values that they return.
Future<T?> showGenericPopUp<T>({
  required BuildContext context,
  required String popUpTitle,
  required String popUpText,
  required DialogOptionsBuilder dialogOptionsBuilder,
}) async {
  final options = dialogOptionsBuilder();
  final PopUpTheme popUpTheme = Theme.of(context).extension<PopUpTheme>()!;
  final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;

  return showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, _, __) {
      // The popup layout.
      return Material(
        color: popUpTheme.overlayColor,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 25.h,
            ),
            width: 320.w,
            decoration: BoxDecoration(
              color: popUpTheme.backgroundColor,
              borderRadius: popUpTheme.borderRadius,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // The dialog title.
                CustomText(
                  text: popUpTitle,
                  textAlign: TextAlign.center,
                  fontSize: 26.sp,
                  color: popUpTheme.titleColor,
                  maxLines: 3,
                ),
                SizedBox(height: 10.h),
                // The dialog content text.
                CustomText(
                  text: popUpText,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  color: popUpTheme.textColor,
                ),
                SizedBox(height: 25.h),
                Row(
                  // Defines how to layout buttons.
                  mainAxisAlignment: options.keys.length == 1
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: options.keys.map(
                    (optionTitle) {
                      final T? optionValue = options[optionTitle];

                      // If optionValue is false, then returns a CustomColors.lightRedColor button.
                      // In any other case returns a CustomColors.mainColor button.
                      if (optionValue == false) {
                        // Red button.
                        return CustomButton(
                          onTap: () {
                            if (optionValue != null) {
                              Navigator.of(context).pop(optionValue);
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          width: 106.w,
                          height: 40.h,
                          backgroundColor: buttonTheme.backgroundColor2,
                          text: optionTitle,
                        );
                      } else {
                        // Green button.
                        return CustomButton(
                          onTap: () {
                            if (optionValue != null) {
                              Navigator.of(context).pop(optionValue);
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          width: 106.w,
                          height: 40.h,
                          text: optionTitle,
                        );
                      }
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

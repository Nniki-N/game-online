import 'package:flutter/material.dart' hide IconTheme, TextTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Color? animationWidgetColor;

  final String? loadingTitle;
  final String? loadingText;

  const LoadingScreen({
    super.key,
    this.backgroundColor,
    this.animationWidgetColor,
    this.loadingTitle,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return Scaffold(
      backgroundColor: backgroundColor ?? backgroundTheme.color,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.hexagonDots(
              color: animationWidgetColor ?? iconTheme.color2,
              size: 100.w,
            ),
            SizedBox(height: 20.h),
            // The title.
            loadingTitle == null
                ? const SizedBox.shrink()
                : CustomText(
                    text: loadingTitle!,
                    textAlign: TextAlign.center,
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w400,
                    color: textTheme.color,
                  ),
            // Space between the title and the text content.
            loadingTitle != null && loadingText != null
                ? SizedBox(height: 5.h)
                : const SizedBox.shrink(),
            // The text content.
            loadingText == null
                ? const SizedBox.shrink()
                : CustomText(
                    text: loadingText!,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    color: textTheme.color3,
                  ),
          ],
        ),
      ),
    );
  }
}

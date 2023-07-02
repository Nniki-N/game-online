import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  final String? loadingTitle;
  final String? loadingText;

  const LoadingScreen({
    super.key,
    this.loadingTitle,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.hexagonDots(
              color: CustomColors.mainColor,
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
                    color: CustomColors.mainTextColor,
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
                    color: CustomColors.secondTextColor,
                  ),
          ],
        ),
      ),
    );
  }
}

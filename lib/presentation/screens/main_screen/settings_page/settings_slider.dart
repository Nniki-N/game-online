import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/widgets/custom_sliders/custom_slider.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

class SettingsSlider extends StatelessWidget {
  final String text;
  final double currentValue;
  final void Function(double value) onCanged;

  const SettingsSlider({
    super.key,
    required this.text,
    required this.currentValue,
    required this.onCanged,
  });

  @override
  Widget build(BuildContext context) {
    final double sliderHeight = 14.h;
    final double sliderSideBarsHeight = 9.h;
    final double sliderSideBarsWidth = 2.5.h;
    final double trackHeight = 1.5.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          fontSize: 14.sp,
        ),
        SizedBox(height: 8.h),
        CustomSlider(
          sliderHeight: sliderHeight,
          trackHeight: trackHeight,
          currentValue: currentValue,
          onCanged: onCanged,
          sliderSideBarsHeight: sliderSideBarsHeight,
          sliderSideBarsWidth: sliderSideBarsWidth,
        )
      ],
    );
  }
}

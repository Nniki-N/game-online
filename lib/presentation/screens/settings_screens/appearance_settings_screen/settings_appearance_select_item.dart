import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/radio_button_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

class SettingsAppearanceSelectItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final SvgPicture svgPicture;
  final VoidCallback? onTap;

  const SettingsAppearanceSelectItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.svgPicture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final RadioButtonTheme radioButtonTheme =
        Theme.of(context).extension<RadioButtonTheme>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          svgPicture,
          SizedBox(height: 6.h),
          CustomText(
            text: text,
            fontSize: 15.sp,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),
          isSelected
              ? Container(
                  width: 17.w,
                  height: 17.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: radioButtonTheme.activColor,
                      width: 1.5.w,
                    ),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Center(
                    child: Container(
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                        color: radioButtonTheme.activColor,
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 17.w,
                  height: 17.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: radioButtonTheme.inactivColor,
                      width: 1.5.w,
                    ),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
        ],
      ),
    );
  }
}

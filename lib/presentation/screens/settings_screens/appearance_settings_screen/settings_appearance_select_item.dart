
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class SettingsAppearanceSelectItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const SettingsAppearanceSelectItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 95.w,
            height: 122.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.grey,
            ),
          ),
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
                      color: CustomColors.mainColor,
                      width: 1.5.w,
                    ),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Center(
                    child: Container(
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                        color: CustomColors.mainColor,
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
                      color: CustomColors.secondTextColor,
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

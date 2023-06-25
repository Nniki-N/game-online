import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class SettingsDetatilsButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SettingsDetatilsButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 15.w,
        ),
        decoration: BoxDecoration(
          color: CustomColors.backgroundLightGrayColor,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: text,
              fontSize: 14.sp,
            ),
            SvgPicture.asset(
              Svgs.arrowForwardIcon,
              width: 18.w,
              colorFilter: ColorFilter.mode(
                CustomColors.mainTextColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

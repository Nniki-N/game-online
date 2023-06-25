import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class ProfileDetailsContainer extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileDetailsContainer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: CustomColors.backgroundLightGrayColor,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
              ),
              clipBehavior: Clip.hardEdge,
              child: SvgPicture.asset(
                Svgs.avatarCyan,
                width: 61.w,
                height: 61.w,
              ),
            ),
            SizedBox(width: 17.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Nickname',
                  fontSize: 20.sp,
                ),
                SizedBox(height: 5.h),
                CustomText(
                  text: '@login',
                  fontSize: 15.sp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

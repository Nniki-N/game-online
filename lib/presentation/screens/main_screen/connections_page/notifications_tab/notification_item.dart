import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class NotificationItem extends StatelessWidget {
  final String username;
  final VoidCallback? onTapDeny;
  final VoidCallback? onTapAccept;

  const NotificationItem({
    super.key,
    required this.username,
    this.onTapDeny,
    this.onTapAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: CustomColors.backgroundGreenGreyColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                ),
                clipBehavior: Clip.hardEdge,
                child: SvgPicture.asset(
                  Svgs.avatarGreen,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              SizedBox(width: 10.w),
              CustomText(text: username),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            height: 1.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: CustomColors.mainMudColor,
                borderRadius: BorderRadius.circular(1.w)),
          ),
          SizedBox(height: 15.h),
          CustomText(
            text: 'Player $username asks to be your friend. Accept?',
            fontSize: 14.sp,
            color: CustomColors.secondTextColor,
            maxLines: 4,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: 'Deny',
                backgroundColor: CustomColors.brightRedColor,
                height: 40.h,
                width: 106.w,
                onTap: onTapDeny,
              ),
              CustomButton(
                text: 'Accept',
                height: 40.h,
                width: 106.w,
                onTap: onTapAccept,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

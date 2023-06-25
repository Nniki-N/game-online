import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class RowWithButtons extends StatelessWidget {
  const RowWithButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'Give up',
            onTap: () {
              //
            },
            width: 106.w,
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          CustomButton(
            text: 'Leave',
            onTap: () {
              //
              AutoRouter.of(context).pop();
            },
            width: 106.w,
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          Container(
            height: 40.h,
            width: 80.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.mainDarkColor,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: '56:00',
              color: CustomColors.mainDarkColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

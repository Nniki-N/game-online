import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/resources/resources.dart';

class LogInFormSeparator extends StatelessWidget {
  const LogInFormSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.h,
            color: CustomColors.mainMudColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SvgPicture.asset(
            Svgs.separatorMidleRectangleIcon,
          ),
        ),
        Expanded(
          child: Container(
            height: 1.h,
            color: CustomColors.mainMudColor,
          ),
        ),
      ],
    );
  }
}

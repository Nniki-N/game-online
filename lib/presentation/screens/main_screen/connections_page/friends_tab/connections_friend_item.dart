import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class ConnectionsFriendItem extends StatelessWidget {
  final String username;
  final int totalGames;
  final int victories;

  const ConnectionsFriendItem({
    super.key,
    required this.username,
    required this.totalGames,
    required this.victories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
          ),
          clipBehavior: Clip.hardEdge,
          child: SvgPicture.asset(
            Svgs.avatarGreen,
            width: 50.w,
            height: 50.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: username),
              SizedBox(height: 6.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'Total games: $totalGames',
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 15.w),
                  CustomText(
                    text: 'Victories: $victories',
                    fontSize: 12.sp,
                  ),
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            //
          },
          child: SvgPicture.asset(
            Svgs.dotsIcon,
            width: 3.w,
            colorFilter: ColorFilter.mode(
              CustomColors.mainTextColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
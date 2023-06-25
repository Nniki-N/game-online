import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';
import 'package:game/resources/resources.dart';

class OnlineHeader extends StatelessWidget {
  const OnlineHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: CustomColors.backgroundGreenGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const RowWithOponentChips(),
          GestureDetector(
            onTap: () {
              //
            },
            child: SvgPicture.asset(
              Svgs.dotsIcon,
              height: 17.h,
              colorFilter: ColorFilter.mode(
                CustomColors.mainTextColor,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowWithOponentChips extends StatelessWidget {
  const RowWithOponentChips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 42.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 34.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}
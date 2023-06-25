import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';
import 'package:game/resources/resources.dart';

class OnlineFooter extends StatelessWidget {
  const OnlineFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: CustomColors.backgroundGreenGreyColor,
      child: const Center(
        child: RowWithChips(),
      ),
    );
  }
}

class RowWithChips extends StatelessWidget {
  const RowWithChips({
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
            Svgs.chipCyan,
            height: 42.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            Svgs.chipCyan,
            height: 34.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            Svgs.chipCyan,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}
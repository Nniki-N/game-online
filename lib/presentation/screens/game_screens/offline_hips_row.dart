import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';

class OfflineChipsRow extends StatelessWidget {
  final String svgPicturePath;

  const OfflineChipsRow({
    super.key,
    required this.svgPicturePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: CustomColors.backgroundGreenGreyColor,
      child: Center(
        child: RowWithChips(
          svgPicturePath: svgPicturePath,
        ),
      ),
    );
  }
}

class RowWithChips extends StatelessWidget {
  final String svgPicturePath;

  const RowWithChips({
    super.key,
    required this.svgPicturePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            svgPicturePath,
            height: 42.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            svgPicturePath,
            height: 34.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: 3,
          svgPicture: SvgPicture.asset(
            svgPicturePath,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}

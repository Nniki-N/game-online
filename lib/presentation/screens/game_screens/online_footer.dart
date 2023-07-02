import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';
import 'package:game/resources/resources.dart';

class OnlineFooter extends StatelessWidget {
  final void Function({required Chips chipSize}) onTap;

  const OnlineFooter({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: CustomColors.backgroundGreenGreyColor,
      child: Center(
        child: RowWithChips(
          onTap: onTap,
        ),
      ),
    );
  }
}

class RowWithChips extends StatelessWidget {
  final void Function({required Chips chipSize}) onTap;

  const RowWithChips({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onTap(chipSize: Chips.chipSize3);
          },
          behavior: HitTestBehavior.opaque,
          child: PlayerChipsCountItem(
            chipsCount: 3,
            svgPicture: SvgPicture.asset(
              Svgs.chipCyan,
              height: 42.h,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            onTap(chipSize: Chips.chipSize2);
          },
          behavior: HitTestBehavior.opaque,
          child: PlayerChipsCountItem(
            chipsCount: 3,
            svgPicture: SvgPicture.asset(
              Svgs.chipCyan,
              height: 34.h,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            onTap(chipSize: Chips.chipSize1);
          },
          behavior: HitTestBehavior.opaque,
          child: PlayerChipsCountItem(
            chipsCount: 3,
            svgPicture: SvgPicture.asset(
              Svgs.chipCyan,
              height: 28.h,
            ),
          ),
        ),
      ],
    );
  }
}

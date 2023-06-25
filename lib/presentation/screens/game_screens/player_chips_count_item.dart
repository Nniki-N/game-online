
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class PlayerChipsCountItem extends StatelessWidget {
  final int chipsCount;
  final SvgPicture svgPicture;

  const PlayerChipsCountItem({
    super.key,
    required this.chipsCount,
    required this.svgPicture,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        svgPicture,
        SizedBox(width: 8.w),
        CustomText(
          text: '${chipsCount}x',
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

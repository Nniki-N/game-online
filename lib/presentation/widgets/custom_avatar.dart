import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/utils/avatar_selecting.dart';

class CustomAvatar extends StatelessWidget {
  final String? avatarLink;
  final double size;

  const CustomAvatar({
    super.key,
    this.avatarLink,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
      ),
      clipBehavior: Clip.hardEdge,
      child: avatarLink != null
          ? Image.network(
              avatarLink!,
              width: size,
              height: size,
              fit: BoxFit.cover,
            )
          : SvgPicture.asset(
              selectRandomBasicAvatar(),
              width: size,
              height: size,
            ),
    );
  }
}

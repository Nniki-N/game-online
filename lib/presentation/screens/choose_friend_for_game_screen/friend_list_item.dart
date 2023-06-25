
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class FriendsListItem extends StatelessWidget {
  final String username;
  final VoidCallback? onTap;

  const FriendsListItem({
    super.key,
    required this.username,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
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
    );
  }
}

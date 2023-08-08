import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/utils/avatar_selecting.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class FriendsListItem extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const FriendsListItem({
    super.key,
    required this.account,
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
            child: account.avatarLink != null
              ? Image.network(
                  account.avatarLink!,
                  width: 40.w,
                  height: 40.w,
                )
              : SvgPicture.asset(
                  selectRandomBasicAvatar(),
                  width: 40.w,
                  height: 40.w,
                ),
          ),
          SizedBox(width: 10.w),
          CustomText(text: account.username),
        ],
      ),
    );
  }
}

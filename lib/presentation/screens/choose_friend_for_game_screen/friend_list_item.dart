import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/widgets/custom_avatar.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

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
          CustomAvatar(
            avatarLink: account.avatarLink,
            size: 40.w,
          ),
          SizedBox(width: 10.w),
          CustomText(text: account.username),
        ],
      ),
    );
  }
}

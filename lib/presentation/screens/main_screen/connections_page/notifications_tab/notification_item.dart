import 'package:flutter/material.dart' hide ButtonTheme, Notification;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/utils/avatar_selecting.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/notification_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationItem extends StatelessWidget {
  final Notification notification;
  final VoidCallback? onTapDeny;
  final VoidCallback? onTapAccept;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTapDeny,
    this.onTapAccept,
  });

  @override
  Widget build(BuildContext context) {
    final NotificationTheme notificationTheme =
        Theme.of(context).extension<NotificationTheme>()!;
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: notificationTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                ),
                clipBehavior: Clip.hardEdge,
                child: notification.sender.avatarLink != null
              ? Image.network(
                  notification.sender.avatarLink!,
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
              CustomText(
                text: notification.sender.username,
                color: notificationTheme.usernameColor,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            height: 1.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: notificationTheme.separatorColor,
                borderRadius: BorderRadius.circular(1.w)),
          ),
          SizedBox(height: 15.h),
          CustomText(
            text:
                '${AppLocalizations.of(context)!.player} ${notification.sender.username} ${AppLocalizations.of(context)!.asksToBeYourFriend}',
            fontSize: 14.sp,
            color: notificationTheme.textColor,
            maxLines: 4,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: AppLocalizations.of(context)!.deny,
                backgroundColor: buttonTheme.backgroundColor2,
                height: 40.h,
                width: 106.w,
                onTap: onTapDeny,
              ),
              CustomButton(
                text: AppLocalizations.of(context)!.accept,
                height: 40.h,
                width: 106.w,
                onTap: onTapAccept,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

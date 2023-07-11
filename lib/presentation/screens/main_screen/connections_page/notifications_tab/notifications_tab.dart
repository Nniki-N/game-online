import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/main_screen/connections_page/notifications_tab/notification_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30.h),
        itemCount: 3,
        itemBuilder: (context, index) {
          return NotificationItem(
            username: AppLocalizations.of(context)!.username,
            onTapDeny: () {
              //
            },
            onTapAccept: () {
              //
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}

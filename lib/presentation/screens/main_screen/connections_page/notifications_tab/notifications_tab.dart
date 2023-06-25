import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/main_screen/connections_page/notifications_tab/notification_item.dart';

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
            username: 'Username',
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

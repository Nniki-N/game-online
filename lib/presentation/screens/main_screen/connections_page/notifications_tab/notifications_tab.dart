import 'package:flutter/material.dart' hide Notification, TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_state.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/screens/main_screen/connections_page/notifications_tab/notification_item.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;

    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, notificationState) {
        final List<Notification> notificationsList = notificationState
            .notificationsList
            .where(
              (notification) =>
                  notification.notificationType == NotificationTypes.gameOffer,
            )
            .toList();

        return notificationsList.isEmpty
            ? Center(
                child: CustomText(
                  text:
                      AppLocalizations.of(context)!.youDontHaveAnyNotifications,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  color: textTheme.color3,
                ),
              )
            : SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 30.h),
                  itemCount: notificationsList.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      notification: notificationsList[index],
                      onTapDeny: () {
                        //
                        //
                        //
                        // Deletes notification.
                        context
                            .read<NotificationBloc>()
                            .add(DeleteForCurrentUserNotificationEvent(
                              notificationUid: notificationsList[index].uid,
                            ));

                        // Sends game offer denial notificaton.
                        context
                            .read<NotificationBloc>()
                            .add(SendDenianOfGameOfferNotificationEvent(
                              recipientUid: notificationsList[index].sender.uid,
                              gameRoom: notificationsList[index].gameRoom,
                            ));
                        //
                        //
                        //
                      },
                      onTapAccept: () {
                        // Deletes notification.
                        context
                            .read<NotificationBloc>()
                            .add(DeleteForCurrentUserNotificationEvent(
                              notificationUid: notificationsList[index].uid,
                            ));

                        // Adds user to the game room.
                        context.read<RoomBloc>().add(JoinRoomEvent(
                              gameRoom: notificationsList[index].gameRoom,
                            ));
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                ),
              );
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart' hide IconTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/common/utils/avatar_selecting.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/popup_menu_theme.dart';
import 'package:game/presentation/widgets/custom_popup_menu_divider/custom_popup_menu_divider.dart';
import 'package:game/presentation/widgets/custom_popups/show_accept_or_deny_popup.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectionsFriendItem extends StatelessWidget {
  final Account account;

  const ConnectionsFriendItem({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final PopUpMenuTheme popUpMenuTheme =
        Theme.of(context).extension<PopUpMenuTheme>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
          ),
          clipBehavior: Clip.hardEdge,
          child: account.avatarLink != null
              ? Image.network(
                  account.avatarLink!,
                  width: 50.w,
                  height: 50.w,
                )
              : SvgPicture.asset(
                  selectRandomBasicAvatar(),
                  width: 50.w,
                  height: 50.w,
                ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: account.username),
              SizedBox(height: 6.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text:
                        '${AppLocalizations.of(context)!.totalGames}: ${account.gamesCount}',
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 15.w),
                  CustomText(
                    text:
                        '${AppLocalizations.of(context)!.victories}: ${account.victoriesCount}',
                    fontSize: 12.sp,
                  ),
                ],
              )
            ],
          ),
        ),
        PopupMenuButton<int>(
          padding: EdgeInsets.zero,
          color: popUpMenuTheme.backgroundColor,
          shadowColor: popUpMenuTheme.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: popUpMenuTheme.borderRadius,
          ),
          onSelected: (index) async {
            switch (index) {
              case 0:
                // Retrieves a room bloc to be used to a send game offer notification later.
                final RoomBloc roomBloc = context.read<RoomBloc>();

                // Creates a private room for a game between friends.
                roomBloc.add(const CreateRoomEvent(private: true));

                // Retrieves a room state base on creating game room process.
                final RoomState roomState = await roomBloc.stream.firstWhere(
                  (state) => state is InRoomState,
                  orElse: () => const ErrorRoomState(
                    gameRoomError: GameRoomErrorUnknown(),
                  ),
                );

                // Sends a game offer notification to the friend.
                if (roomState is InRoomState) {
                  context
                      .read<NotificationBloc>()
                      .add(SendGameOfferNotificationEvent(
                        recipientUid: account.uid,
                        gameRoom: roomState.getGameRoom()!,
                      ));
                }

                break;
              case 1:
                showAcceptOrDenyPopUp(
                  context: context,
                  dialogTitle: AppLocalizations.of(context)!.removeFromFriends,
                  dialogContent: AppLocalizations.of(context)!.areYouSure,
                  buttonAcceptText: AppLocalizations.of(context)!.remove,
                  buttonDenyText: AppLocalizations.of(context)!.cancel,
                ).then((remove) {
                  log('$remove');
                  if (remove) {
                    context
                        .read<FriendsBloc>()
                        .add(RemoveFriendsEvent(friendUid: account.uid));
                  }
                });
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              height: 17.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
              child: CustomText(
                text: AppLocalizations.of(context)!.offerAGame,
                fontSize: 14.sp,
              ),
            ),
            CustomPopupMenuDivider(
              color: popUpMenuTheme.separatorColor,
              thickness: 1.h,
            ),
            PopupMenuItem<int>(
              value: 1,
              height: 17.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
              child: CustomText(
                text: AppLocalizations.of(context)!.removeFromFriends,
                fontSize: 14.sp,
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 2.w),
            child: SvgPicture.asset(
              Svgs.dots,
              width: 3.w,
              colorFilter: ColorFilter.mode(
                iconTheme.color,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

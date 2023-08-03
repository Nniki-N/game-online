import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide IconTheme, TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;
        
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, roomState) {
        // Navigates user back to the main screen if the user is outside the room.
        if (roomState is OutsideRoomState) {
          log('waiting room ------------------ go to the main screen');
          AutoRouter.of(context).replace(const MainRouter());
        }

        // Navigates to the online game room screen if the game room is full.
        else if (roomState is InFullRoomState) {
          log('waiting room ------------------ go to the online game room screen');
          AutoRouter.of(context).replace(const OnlineGameRouter());
        }

        // Navigates user back to the main screen if an error occurs.
        else if (roomState is ErrorRoomState) {
          log('roomError in the waiting room screen');
          AutoRouter.of(context).replace(const MainRouter());
        }
      },
      builder: (context, state) {
        String waitingText = AppLocalizations.of(context)!.searching;

        if (state is SearchingRoomState) {
          waitingText = AppLocalizations.of(context)!.searchingForFreeRoom;
        } else if (state is InRoomState) {
          waitingText = AppLocalizations.of(context)!.searchingForSecondPlayer;
        }

        return Scaffold(
          backgroundColor: backgroundTheme.color,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingAnimationWidget.hexagonDots(
                        color: iconTheme.color2,
                        size: 100.w,
                      ),
                      SizedBox(height: 35.h),
                      CustomText(
                        text: waitingText,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        color: textTheme.color3,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 45.h,
                left: 30.w,
                right: 30.w,
                child: Row(
                  children: [
                    CustomButtonBack(
                      onTap: () {
                        context.read<RoomBloc>().add(LeaveRoomEvent(
                              gameRoom: (state as InRoomState).gameRoom,
                              leaveWithLoose: false,
                            ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

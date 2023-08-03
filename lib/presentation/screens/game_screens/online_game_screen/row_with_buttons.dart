import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/bloc/game_bloc/game_event.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/leave_game_room.dart';
import 'package:game/presentation/theme/extensions/timer_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_popups/show_accept_or_deny_popup.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RowWithButtons extends StatelessWidget {
  const RowWithButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TimerTheme timerTheme = Theme.of(context).extension<TimerTheme>()!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: AppLocalizations.of(context)!.giveUp,
            onTap: () {
              showAcceptOrDenyPopUp(
                context: context,
                dialogTitle: AppLocalizations.of(context)!.giveUp,
                dialogContent: AppLocalizations.of(context)!.areYouSure,
                buttonAcceptText: AppLocalizations.of(context)!.giveUp,
                buttonDenyText: AppLocalizations.of(context)!.cancel,
              ).then((giveUp) {
                if (giveUp) {
                  context.read<GameBloc>().add(const GiveUpGameEvent());
                }
              });
            },
            width: 106.w,
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          CustomButton(
            text: AppLocalizations.of(context)!.leave,
            onTap: () {
              showAcceptOrDenyPopUp(
                context: context,
                dialogTitle: AppLocalizations.of(context)!.leaveTheGame,
                dialogContent: AppLocalizations.of(context)!.areYouSure,
                buttonAcceptText: AppLocalizations.of(context)!.leave,
                buttonDenyText: AppLocalizations.of(context)!.cancel,
              ).then((leave) {
                if (leave) {
                  leaveGameRoom(
                    context: context,
                    leaveWithLoose: true,
                  );
                }
              });
            },
            width: 106.w,
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          Container(
            height: 40.h,
            width: 80.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: timerTheme.color,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: '56:00',
              color: timerTheme.color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ButtonTheme, IconTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_text_button.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Svgs.logoIngame,
                width: 155.w,
                height: 155.w,
                colorFilter: ColorFilter.mode(
                  iconTheme.color,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: AppLocalizations.of(context)!.gameName,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 65.h),
              CustomButton(
                text: AppLocalizations.of(context)!.playWithRandomPlayer,
                onTap: () {
                  // Searches for a room.
                  // Creates a room if there are no rooms.
                  final RoomBloc roomBloc = context.read<RoomBloc>();
                  roomBloc.add(const SearchRoomEvent());
                },
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: AppLocalizations.of(context)!.playWithFriend,
                onTap: () {
                  AutoRouter.of(context)
                      .push(const ChoosefriendForGameRouter());
                },
              ),
              SizedBox(height: 35.h),
              CustomIconTextButton(
                text: AppLocalizations.of(context)!.gameRules,
                onTap: () {
                  AutoRouter.of(context).push(const GameRulesRouter());
                },
                foregroundColor: buttonTheme.textColor3,
                svgPicture: SvgPicture.asset(
                  Svgs.inform,
                  width: 15.w,
                  height: 15.w,
                  colorFilter: ColorFilter.mode(
                    iconTheme.color3,
                    BlendMode.srcIn,
                  ),
                ),
                spaceBetween: 7.w,
                textDecoration: TextDecoration.underline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

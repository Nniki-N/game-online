import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_text_button.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Svgs.logoIngameIcon,
                width: 155.w,
                height: 155.w,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: 'Tic Tac Toe',
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 45.h),
              CustomButton(
                text: 'Play on one device',
                onTap: () {
                  AutoRouter.of(context).replace(const OfflineGameRouter());
                },
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'Play with random player',
                onTap: () {
                  // Searching for a room.
                  // Creates a room if there are no rooms.
                  final RoomBloc roomBloc = context.read<RoomBloc>();
                  roomBloc.add(const SearchRoomEvent());
                },
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'Play with friend',
                onTap: () {
                  AutoRouter.of(context)
                      .replace(const ChoosefriendForGameRouter());
                },
              ),
              SizedBox(height: 35.h),
              CustomIconTextButton(
                text: 'Game rules',
                onTap: () {
                  AutoRouter.of(context).push(const GameRulesRouter());
                },
                color: CustomColors.mainDarkColor,
                svgPicture: SvgPicture.asset(
                  Svgs.informIcon,
                  width: 15.w,
                  height: 15.w,
                  colorFilter: ColorFilter.mode(
                    CustomColors.mainDarkColor,
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

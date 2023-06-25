import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_text_button.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.image, size: 200),
//           const Text('Tic Tac Toe'),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {
//               AutoRouter.of(context).navigate(const OfflineGameRouter());
//             },
//             child: const Text('Play on one device'),
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {
//               // searching for a room
//               // creates a room if there are no rooms
//               final RoomBloc roomBloc = context.read<RoomBloc>();
//               roomBloc.add(const SearchRoomEvent());
//
//               // temporary method of navigating to the eaiting room
//               AutoRouter.of(context).navigate(const WaitingRoomRouter());
//             },
//             child: const Text('Play with a random player'),
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {
//               // AutoRouter.of(context).navigate(const WaitingRoomRouter());
//             },
//             child: const Text('Play with a friend'),
//           ),
//           const SizedBox(height: 15),
//           TextButton(
//             onPressed: () {
//               // LoadingOverlay.instance().show(
//               //   context: context,
//               //   title: null,
//               //   text: null,
//               // );
//               showNotificationDialog(
//                 context: context,
//                 dialogTitle: 'Text',
//                 dialogContent:
//                     'Lorem Ipsum is simply dummy text of the printing and',
//                 buttonText: 'Ok',
//               );
//             },
//             child: const Text('Game rules'),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                  AutoRouter.of(context).push(const OfflineGameRouter());
                },
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'Play with random player',
                onTap: () {
                  AutoRouter.of(context).push(const OnlineGameRouter());
                },
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'Play with friend',
                onTap: () {
                  AutoRouter.of(context)
                      .push(const ChoosefriendForGameRouter());
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

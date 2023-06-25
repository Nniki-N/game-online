
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// class WaitingRoomScreen extends StatelessWidget {
//   const WaitingRoomScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RoomBloc, RoomState>(
//       listener: (context, state) {
//         if (state is InFullRoomState) {
//           log('waiting room ------------------ go to online game room');
//           AutoRouter.of(context).replace(const OnlineGameRouter());
//         }
//
//         if (state is OutsideRoomState) {
//           log('waiting room ------------------ go to main');
//           AutoRouter.of(context).replace(const MainRouter());
//         }
//
//         if (state is ErrorRoomState) {
//           log('waiting room via error------------------ go to main');
//           AutoRouter.of(context).replace(const MainRouter());
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Column(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   AutoRouter.of(context).pop();
//                 },
//                 icon: const Icon(Icons.arrow_back),
//               ),
//               Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.image,
//                       size: 50,
//                     ),
//                     const Text('Room was created'),
//                     const Text(
//                       'The second player is in the search, please wait a bit...',
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       onPressed: () {
//                         AutoRouter.of(context)
//                             .navigate(const OnlineGameRouter());
//                       },
//                       child: const Text('Go to online game room'),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingAnimationWidget.hexagonDots(
                    color: CustomColors.mainColor,
                    size: 100.w,
                  ),
                  SizedBox(height: 35.h),
                  CustomText(
                    text: 'Room was created',
                    fontSize: 26.sp,
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    text:
                        'The second player is in the search, please wait a bit...',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    color: CustomColors.secondTextColor,
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
                    AutoRouter.of(context).pop();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

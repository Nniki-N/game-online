import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/settings_screens/appearance_settings_screen/settings_appearance_select_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/switches/custom_switch.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

// class AppearanceSettingsAcreen extends StatelessWidget {
//   const AppearanceSettingsAcreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             onPressed: () {
//               AutoRouter.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.grey,
//                   ),
//                   const Text('light'),
//                 ],
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.grey,
//                   ),
//                   const Text('dark'),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Text('authomatic'),
//                 ],
//               ),
//               Text('Sets theme based on your device’s appearance mode')
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 45.h,
          bottom: 30.h,
          left: 30.w,
          right: 30.w,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CustomButtonBack(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 55.h),
            CustomText(
              text: 'Appearance',
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingsAppearanceSelectItem(
                  text: 'Light',
                  isSelected: true,
                  onTap: () {
                    //
                  },
                ),
                SizedBox(width: 40.w),
                SettingsAppearanceSelectItem(
                  text: 'Dark',
                  isSelected: false,
                  onTap: () {
                    //
                  },
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: 'Automatic'),
                CustomSwitch(
                  isSelected: true,
                  onChanged: (value) {
                    //
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(
              text: 'Sets theme based on your device’s appearance mode.',
              maxLines: 3,
              fontSize: 14.sp,
              color: CustomColors.secondTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

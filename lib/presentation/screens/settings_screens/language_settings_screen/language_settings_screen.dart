import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/settings_screens/language_settings_screen/language_list_view_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

// class LanguageSettingsScreen extends StatelessWidget {
//   const LanguageSettingsScreen({super.key});
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
//           ListView(
//             shrinkWrap: true,
//             children: const [
//               Row(
//                 children: [
//                   Text('English'),
//                   Icon(Icons.arrow_downward),
//                 ],
//               ),
//               Text('Ukrainian'),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 45.h,
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
              text: 'Language',
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 35.h),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return LanguageListViewItem(
                      index: index,
                      text: 'English',
                      isSelected: index == 0,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

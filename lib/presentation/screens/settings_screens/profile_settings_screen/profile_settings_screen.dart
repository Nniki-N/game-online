import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/resources/resources.dart';

// class ProfileSettingsScreen extends StatelessWidget {
//   const ProfileSettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           IconButton(
//             onPressed: () {
//               AutoRouter.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back),
//           ),
//           const SizedBox(height: 20),
//           const Icon(
//             Icons.image,
//             size: 50,
//           ),
//           const SizedBox(height: 20),
//           const TextField(
//             decoration: InputDecoration(
//               hintText: 'Username',
//             ),
//           ),
//           const SizedBox(height: 10),
//           const TextField(
//             decoration: InputDecoration(
//               hintText: 'Login',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               //
//             },
//             child: const Text('Save changes'),
//           ),
//           const Divider(),
//           BlocBuilder<AuthBloc, AuthState>(
//             builder: (context, authState) {
//               if (!authState.isAnonymousUser()) {
//                 return const SizedBox.shrink();
//               }
//
//               return ElevatedButton(
//                 onPressed: () {
//                   //
//                 },
//                 child: const Text('Register'),
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               // context.read<AuthBloc>().add(const LogOutAuthEvent());
//             },
//             child: const Text('Log out'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController loginController = TextEditingController();

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
            SizedBox(height: 35.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
              ),
              clipBehavior: Clip.hardEdge,
              child: SvgPicture.asset(
                Svgs.avatarCyan,
                width: 100.w,
                height: 100.w,
              ),
            ),
            SizedBox(height: 12.h),
            CustomTextButton(
              text: 'Set new photo',
              onTap: () {
                //
              },
            ),
            SizedBox(height: 35.h),
            CustomField(
              controller: usernameController,
              hintText: 'Usrename',
            ),
            SizedBox(height: 20.h),
            CustomField(
              controller: loginController,
              hintText: 'Login',
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'Save changes',
              onTap: () {
                //
              },
            ),
            const Spacer(),
            CustomOutlinedButton(
              text: 'Log out',
              color: CustomColors.darkRedColor,
            ),
          ],
        ),
      ),
    );
  }
}

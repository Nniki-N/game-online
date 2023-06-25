import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class SettingsRegisterScreen extends StatelessWidget {
  const SettingsRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController loginController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordasswordController =
        TextEditingController();

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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Register your account',
                      fontSize: 26.sp,
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: 'All your score will be saved',
                      color: CustomColors.secondTextColor,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    SizedBox(height: 25.h),
                    CustomField(
                      controller: usernameController,
                      hintText: 'Username',
                    ),
                    SizedBox(height: 20.h),
                    CustomField(
                      controller: loginController,
                      hintText: 'Login',
                    ),
                    SizedBox(height: 20.h),
                    CustomField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 20.h),
                    CustomField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    CustomField(
                      controller: repeatPasswordasswordController,
                      hintText: 'Repeat password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Register',
                      onTap: () {
                        //
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

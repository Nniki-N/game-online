import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/resources/resources.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController loginController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // // Shows loading.
        // if (state is LoadingAuthState) {
        //   log('profile settings ------------------ show loading');
        //   LoadingOverlay.instance().show(
        //     title: null,
        //     context: context,
        //     text: 'Loading...',
        //   );
        // } else {
        //   // log('profile settings ------------------ hide loading');
        //   // LoadingOverlay.instance().hide();
        // }

        // Displays an error message if an error accurs.
        final authError = state.error;
        if (authError != null) {
          log('error profile settings');
          showNotificationDialog(
            context: context,
            dialogTitle: authError.errorTitle,
            dialogContent: authError.errorText,
            buttonText: 'Ok',
          );
        }

        // Navigates to the sign in screen if the user is logged out.
        if (state is LoggedOutAuthState) {
          log('profile settings ------------------ log out and go to the sign in screen');
          context.read<AccountBloc>().add(const LogOutAccountEvent());
          AutoRouter.of(context).replaceAll(const [SignInRouter()]);
        }
      },
      child: Scaffold(
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
                onTap: () {
                  log('profile settings ------------------ log out button pressed');
                  context.read<AuthBloc>().add(const LogOutAuthEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

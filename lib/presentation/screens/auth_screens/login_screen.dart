import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/auth_screens/login_form_separator.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: 'user1@gmail.com');
    final TextEditingController passwordController =
        TextEditingController(text: '12345678');

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Shows loading.
        // if (state is LoadingAuthState) {
        //   log('signin ------------------ show loading');
        //   LoadingOverlay.instance().show(
        //     title: null,
        //     context: context,
        //     text: 'Loading...',
        //   );
        // } else {
        //   // log('signin ------------------ hide loading');
        //   // LoadingOverlay.instance().hide();
        // }

        // Displays an error message if an error accurs.
        final authError = state.error;
        if (authError != null) {
          log('error signin');
          showNotificationDialog(
            context: context,
            dialogTitle: authError.errorTitle,
            dialogContent: authError.errorText,
            buttonText: 'Ok',
          );
        }

        // Navigates to the main screen if the user is logged in.
        else if (state is LoggedInAuthState) {
          log('signin ------------------ go to the main');
          AutoRouter.of(context).replace(const MainRouter());
        }
      },
      builder: (context, state) {
        // Loading screen.
        if (state is LoadingAuthState || state is LoggedInAuthState) {
          return const LoadingScreen(
            loadingText: 'Loading...',
          );
        } 
        // Sign in screen.    
        else {
          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Sign in',
                            fontSize: 27.sp,
                            color: CustomColors.mainTextColor,
                          ),
                          CustomTextButton(
                            text: 'Register',
                            onTap: () {
                              log('signin ------------------ go to the registration screen');
                              AutoRouter.of(context)
                                  .replace(const RegistrationRouter());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      CustomField(
                        controller: emailController,
                        hintText: 'Email',
                        validatorText: 'email is incorrect',
                      ),
                      SizedBox(height: 20.h),
                      CustomField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        text: 'Sign in',
                        onTap: () {
                          log('signin ------------------ sign in button pressed');
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isNotEmpty && password.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                  LogInAuthEvent(
                                    email: email,
                                    password: password,
                                  ),
                                );
                          }
                        },
                      ),
                      SizedBox(height: 35.h),
                      const LogInFormSeparator(),
                      SizedBox(height: 35.h),
                      CustomOutlinedButton(
                        text: 'Sign in anonymously',
                        color: CustomColors.mainDarkColor,
                        onTap: () {
                          log('signin ------------------ sign in anonymously button pressed');
                          context
                              .read<AuthBloc>()
                              .add(const LogInAnonymouslyAuthEvent());
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomIconOutlinedButton(
                        text: 'Sign in with Google',
                        color: CustomColors.mainDarkColor,
                        svgPicture: SvgPicture.asset(
                          Svgs.gogleIcon,
                          width: 28.w,
                          height: 28.w,
                        ),
                        onTap: () {
                          log('signin ------------------ sign in with google button pressed');
                          context
                              .read<AuthBloc>()
                              .add(const LogInWithGoogleAuthEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

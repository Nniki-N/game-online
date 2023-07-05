import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController loginController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordasswordController =
        TextEditingController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
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
          log('register ------------------ go to the main');
          context.read<AccountBloc>().add(const InitializeAccountEvent());
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
        // Register screen.
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
                            text: 'Register',
                            fontSize: 27.sp,
                            color: CustomColors.mainTextColor,
                          ),
                          CustomTextButton(
                            text: 'Sign in',
                            onTap: () {
                              log('registration ------------------ go to the sign in screen');
                              AutoRouter.of(context)
                                  .replace(const SignInRouter());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
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
                          log('registration ------------------ register button is pressed');
                          final String username =
                              usernameController.text.trim();
                          final String login = loginController.text.trim();
                          final String email = emailController.text.trim();
                          final String password =
                              passwordController.text.trim();
                          final String repeatPassword =
                              repeatPasswordasswordController.text.trim();

                          if (username.isNotEmpty &&
                              login.isNotEmpty &&
                              email.isNotEmpty &&
                              password.isNotEmpty &&
                              password == repeatPassword) {
                            final RegisterAuthEvent registerEvent =
                                RegisterAuthEvent(
                              email: email,
                              password: password,
                              username: username,
                              login: login,
                            );

                            context.read<AuthBloc>().add(registerEvent);
                          }
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

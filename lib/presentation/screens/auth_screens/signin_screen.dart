import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/auth_screens/signin_form_separator.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
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
    // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController =
        TextEditingController(text: 'user1@gmail.com');
    final TextEditingController passwordController =
        TextEditingController(text: '12345678');

    return BlocProvider(
      create: (context) => FormValidationBloc(),
      child: BlocListener<FormValidationBloc, FormValidationState>(
        listener: (context, validationState) {
          // Signs in.
          if (validationState is ValidatedFormValidationState) {
            context.read<AuthBloc>().add(LogInAuthEvent(
                  email: emailController.text,
                  password: passwordController.text,
                ));
          }
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // Checks if an error occurs and if error message has to be shown.
            final AuthError? authError = state.error;
            final bool showPopupWithError =
                authError is AuthErrorInvalidEmail ||
                    authError is AuthErrorInvalidPassword ||
                    authError is AuthErrorWrongPassword ||
                    authError is AuthErrorCredentialAlreadyInUse ||
                    authError is AuthErrorUserNotFound ||
                    authError is AuthErrorOperationNotAllowed;
            final bool showPopupWithBasicSentences =
                authError is! AuthErrorGoogleSignInWasAborted &&
                    authError is! AuthErrorUnknown;

            // Displays an error message if needed.
            if (authError != null && showPopupWithError) {
              showNotificationDialog(
                context: context,
                dialogTitle: authError.errorTitle,
                dialogContent: authError.errorText,
                buttonText: 'Ok',
              );
            } else if (authError != null && showPopupWithBasicSentences) {
              showNotificationDialog(
                context: context,
                dialogTitle: 'Authentication error',
                dialogContent:
                    'Something went wrong while signing, please try again',
                buttonText: 'Ok',
              );
            }

            // Navigates to the main screen if the user is logged in.
            else if (state is LoggedInAuthState) {
              log('signin ------------------ go to the main');
              context.read<AccountBloc>().add(const InitializeAccountEvent());
              AutoRouter.of(context).replace(const MainRouter());
            }

            // Indicates that the current user is logged out.
            else if (state is LoggedOutAuthState) {
              context.read<AccountBloc>().add(const LogOutAccountEvent());
            }
          },
          builder: (context, state) {
            // Loading screen.
            if (state is LoadingAuthState || state is LoggedInAuthState) {
              return const LoadingScreen(
                loadingText: 'Loading...',
              );
            }

            // Sign in screen layout.
            else {
              return Scaffold(
                body: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
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
                          const ValidationMessagesList(),
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
                          CustomButton(
                            text: 'Sign in',
                            onTap: () {
                              log('signin ------------------ sign in button pressed');

                              final String email = emailController.text;
                              final String password = passwordController.text;

                              // Validates an email.
                              context
                                  .read<FormValidationBloc>()
                                  .add(EmailFormValidationEvent(email: email));

                              // Validates a password.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: password,
                                    lastValidation: true,
                                    minSymbols: 6,
                                    validationForbiddenSymbolsText:
                                        'Symbols [] are forbidden to use in the password',
                                    validationEmptyText:
                                        'Please enter the password',
                                    validationToManySymbolsText:
                                        'Maximal length of the password is 55 symbols',
                                    validationNotEnoughtSymbolsText:
                                        'Minimal lenght of the password is 6 symbols',
                                  ));
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
        ),
      ),
    );
  }
}

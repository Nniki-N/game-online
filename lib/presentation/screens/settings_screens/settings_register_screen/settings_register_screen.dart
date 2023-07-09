import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';

class SettingsRegisterScreen extends StatelessWidget {
  const SettingsRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController loginController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordController =
        TextEditingController();

    return BlocProvider(
      create: (context) => FormValidationBloc(),
      child: BlocListener<FormValidationBloc, FormValidationState>(
        listener: (context, validationState) {
          // Registers anonymous user.
          if (validationState is ValidatedFormValidationState) {
            final RegisterAnonymousUserAuthEvent registerAnonymousUserEvent =
                RegisterAnonymousUserAuthEvent(
              email: emailController.text,
              password: passwordController.text,
              login: loginController.text,
              username: usernameController.text,
            );

            context.read<AuthBloc>().add(registerAnonymousUserEvent);
          }
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // Checks if an error occurs and if error message has to be shown.
            final AuthError? authError = state.error;
            final bool showPopupWithError = authError
                    is AuthErrorLoginIsAlreadyUsed ||
                authError is AuthErrorEmailAlreadyInUse ||
                authError is AuthErrorCredentialAlreadyInUse ||
                authError is AuthErrorWeakPassword ||
                authError is AuthErrorOperationNotAllowed ||
                authError is AuthErrorAccountExistsWithDifferentCredential ||
                authError is AuthErrorInvalidPassword ||
                authError is AuthErrorInvalidEmail;
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
                dialogTitle: 'Registration error',
                dialogContent:
                    'Something went wrong while registration, please try again',
                buttonText: 'Ok',
              );
            }

            // Navigates to the main screen if the user is logged in.
            else if (state is LoggedInAuthState) {
              log('register ------------------ go to the main');
              context.read<AccountBloc>().add(const InitializeAccountEvent());
              AutoRouter.of(context).pop();
            }
          },
          builder: (context, state) {
            // Loading screen.
            if (state is LoadingAuthState) {
              return const LoadingScreen(
                loadingText: 'Loading...',
              );
            }

            // Registration screen layout.
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
                            const ValidationMessagesList(),
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
                              controller: repeatPasswordController,
                              hintText: 'Repeat password',
                              obscureText: true,
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              text: 'Register',
                              onTap: () {
                                log('registration ------------------ register button is pressed');
                                final String username = usernameController.text;
                                final String login = loginController.text;
                                final String email = emailController.text;
                                final String password = passwordController.text;
                                final String repeatPassword =
                                    repeatPasswordController.text;

                                // Validates a username.
                                context
                                    .read<FormValidationBloc>()
                                    .add(TextFormValidationEvent(
                                      text: username,
                                      maxSymbols: 15,
                                      validationForbiddenSymbolsText:
                                          'Symbols [] are forbidden to use in the username',
                                      validationEmptyText:
                                          'Please enter the username',
                                      validationToManySymbolsText:
                                          'Maximal length of the username is 15 symbols',
                                      validationNotEnoughtSymbolsText:
                                          'Minimal lenght of the username is 3 symbols',
                                    ));

                                // Validates a login.
                                context
                                    .read<FormValidationBloc>()
                                    .add(TextFormValidationEvent(
                                      text: login,
                                      maxSymbols: 15,
                                      validationForbiddenSymbolsText:
                                          'Symbols [] are forbidden to use in the login',
                                      validationEmptyText:
                                          'Please enter the login',
                                      validationToManySymbolsText:
                                          'Maximal length of the login is 15 symbols',
                                      validationNotEnoughtSymbolsText:
                                          'Minimal lenght of the login is 3 symbols',
                                    ));

                                // Validates an email.
                                context
                                    .read<FormValidationBloc>()
                                    .add(EmailFormValidationEvent(
                                      email: email,
                                      // lastValidation: true,
                                    ));

                                // Validates a password.
                                context
                                    .read<FormValidationBloc>()
                                    .add(TextFormValidationEvent(
                                      text: password,
                                      minSymbols: 6,
                                      // lastValidation: true,
                                      validationForbiddenSymbolsText:
                                          'Symbols [] are forbidden to use in the password',
                                      validationEmptyText:
                                          'Please enter the password',
                                      validationToManySymbolsText:
                                          'Maximal length of a password is 55 symbols',
                                      validationNotEnoughtSymbolsText:
                                          'Minimal lenght of a password is 6 symbols',
                                    ));

                                // Validates a repeated password.
                                context
                                    .read<FormValidationBloc>()
                                    .add(SimilarityTextFormValidationEvent(
                                      texts: [password, repeatPassword],
                                      lastValidation: true,
                                      validationFailureText:
                                          'Passords are not equal',
                                    ));
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
          },
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/common/utils/string_extension.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
          // Registers.
          if (validationState is ValidatedFormValidationState) {
            final RegisterAuthEvent registerEvent = RegisterAuthEvent(
              email: emailController.text,
              password: passwordController.text,
              username: usernameController.text,
              login: loginController.text,
            );

            context.read<AuthBloc>().add(registerEvent);
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
                buttonText: AppLocalizations.of(context)!.ok,
              );
            } else if (authError != null && showPopupWithBasicSentences) {
              showNotificationDialog(
                context: context,
                dialogTitle: AppLocalizations.of(context)!.registrationError,
                dialogContent: AppLocalizations.of(context)!
                    .somethingWentWrongRegistration,
                buttonText: AppLocalizations.of(context)!.ok,
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
              return LoadingScreen(
                loadingText: AppLocalizations.of(context)!.loading,
              );
            }

            // Registration screen layout.
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
                                text: AppLocalizations.of(context)!.register,
                                fontSize: 27.sp,
                                color: CustomColors.mainTextColor,
                              ),
                              CustomTextButton(
                                text: AppLocalizations.of(context)!.signIn,
                                onTap: () {
                                  log('registration ------------------ go to the sign in screen');
                                  AutoRouter.of(context)
                                      .replace(const SignInRouter());
                                },
                              ),
                            ],
                          ),
                          const ValidationMessagesList(),
                          CustomField(
                            controller: usernameController,
                            hintText: AppLocalizations.of(context)!.username,
                          ),
                          SizedBox(height: 20.h),
                          CustomField(
                            controller: loginController,
                            hintText: AppLocalizations.of(context)!.login,
                          ),
                          SizedBox(height: 20.h),
                          CustomField(
                            controller: emailController,
                            hintText: AppLocalizations.of(context)!.email,
                          ),
                          SizedBox(height: 20.h),
                          CustomField(
                            controller: passwordController,
                            hintText: AppLocalizations.of(context)!.password,
                            obscureText: true,
                          ),
                          SizedBox(height: 20.h),
                          CustomField(
                            controller: repeatPasswordController,
                            hintText:
                                AppLocalizations.of(context)!.repeatPassword,
                            obscureText: true,
                          ),
                          SizedBox(height: 20.h),
                          CustomButton(
                            text: AppLocalizations.of(context)!.register,
                            onTap: () {
                              log('registration ------------------ register button is pressed');
                              final String username = usernameController.text;
                              final String login = loginController.text;
                              final String email = emailController.text;
                              final String password = passwordController.text;
                              final String repeatPassword =
                                  repeatPasswordController.text;

                              const int minSymbols = 3;
                              const int maxSymbols = 15;
                              const int minSymbolsForPassword = 6;
                              const int maxSymbolsForPasswor = 55;

                              // Validates a username.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: username,
                                    maxSymbols: maxSymbols,
                                    minSymbols: minSymbols,
                                    validationForbiddenSymbolsText:
                                        '${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.username.toLowerCase()}',
                                    validationEmptyText:
                                        '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.username}',
                                    validationToManySymbolsText:
                                        '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.username} ${AppLocalizations.of(context)!.wordIs} $maxSymbols ${AppLocalizations.of(context)!.symbols}',
                                    validationNotEnoughtSymbolsText:
                                        '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.username} ${AppLocalizations.of(context)!.wordIs} $minSymbols ${AppLocalizations.of(context)!.symbols}',
                                  ));

                              // Validates a login.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: login,
                                    maxSymbols: maxSymbols,
                                    minSymbols: minSymbols,
                                    validationForbiddenSymbolsText:
                                        '${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.login.toLowerCase()}',
                                    validationEmptyText:
                                        '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.login}',
                                    validationToManySymbolsText:
                                        '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $maxSymbols ${AppLocalizations.of(context)!.symbols}',
                                    validationNotEnoughtSymbolsText:
                                        '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $minSymbols ${AppLocalizations.of(context)!.symbols}',
                                  ));

                              // Validates an email.
                              context
                                  .read<FormValidationBloc>()
                                  .add(EmailFormValidationEvent(
                                    email: email,
                                    validationEmptyEmail:
                                        AppLocalizations.of(context)!
                                            .pleaseEnterYourEmailAddress,
                                    validationIncorrectEmail:
                                        AppLocalizations.of(context)!
                                            .emailAddressIsIncorrect,
                                  ));

                              // Validates a password.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: password,
                                    minSymbols: minSymbolsForPassword,
                                    maxSymbols: maxSymbolsForPasswor,
                                    validationForbiddenSymbolsText:
                                        '${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.password.toLowerCase()}',
                                    validationEmptyText:
                                        '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.password}',
                                    validationToManySymbolsText:
                                        '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.wordIs} $maxSymbolsForPasswor ${AppLocalizations.of(context)!.symbols}',
                                    validationNotEnoughtSymbolsText:
                                        '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.wordIs} $minSymbolsForPassword ${AppLocalizations.of(context)!.symbols}',
                                  ));

                              // Validates a repeated password.
                              context
                                  .read<FormValidationBloc>()
                                  .add(SimilarityTextFormValidationEvent(
                                    texts: [password, repeatPassword],
                                    lastValidation: true,
                                    validationFailureText:
                                        AppLocalizations.of(context)!
                                            .passordsAreNotEqual,
                                  ));
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

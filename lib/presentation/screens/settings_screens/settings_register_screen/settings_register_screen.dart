import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/utils/error_localization_convertor.dart';
import 'package:game/common/utils/string_extension.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_popups/show_notification_popup.dart';
import 'package:game/presentation/widgets/custom_fields/custom_field.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

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
              showNotificationPopUp(
                context: context,
                popUpTitle:
                    getLocalizatedError(context, error: authError).errorTitle,
                popUpText:
                    getLocalizatedError(context, error: authError).errorText,
                buttonText: AppLocalizations.of(context)!.ok,
              );
            } else if (authError != null && showPopupWithBasicSentences) {
              showNotificationPopUp(
                context: context,
                popUpTitle: AppLocalizations.of(context)!.registrationError,
                popUpText: AppLocalizations.of(context)!
                    .somethingWentWrongRegistration,
                buttonText: AppLocalizations.of(context)!.ok,
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
              return LoadingScreen(
                loadingText: AppLocalizations.of(context)!.loading,
              );
            }

            // Registration screen layout.
            return Scaffold(
              backgroundColor: backgroundTheme.color,
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
                              text: AppLocalizations.of(context)!
                                  .registerYourAccount,
                              fontSize: 26.sp,
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              text: AppLocalizations.of(context)!
                                  .allYourScoreWillBeSaved,
                              color: textTheme.color3,
                              textAlign: TextAlign.center,
                              maxLines: 3,
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

                                final bool isInternetConnected = context
                                    .read<InternetConnectionBloc>()
                                    .state is ConnectedInternetConnectionState;

                                if (isInternetConnected) {
                                  final String username =
                                      usernameController.text;
                                  final String login = loginController.text;
                                  final String email = emailController.text;
                                  final String password =
                                      passwordController.text;
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
                                } else {
                                  showNotificationPopUp(
                                    context: context,
                                    popUpTitle: AppLocalizations.of(context)!
                                        .disconnected,
                                    popUpText: AppLocalizations.of(context)!
                                        .thereIsNoInternetConnection,
                                    buttonText:
                                        AppLocalizations.of(context)!.ok,
                                  );
                                }
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

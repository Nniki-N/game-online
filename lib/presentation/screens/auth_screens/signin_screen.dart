import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme, ButtonTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/navigation/app_router.gr.dart';
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
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/screens/auth_screens/signin_form_separator.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/custom_popups/show_notification_popup.dart';
import 'package:game/presentation/widgets/custom_fields/custom_field.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

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
          listener: (context, authState) {
            // Checks if an error occurs and if error message has to be shown.
            final AuthError? authError = authState.error;
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
                popUpTitle: AppLocalizations.of(context)!.authenticationError,
                popUpText:
                    AppLocalizations.of(context)!.somethingWentWrongSignIn,
                buttonText: AppLocalizations.of(context)!.ok,
              );
            }

            // Navigates to the main screen if the user is logged in.
            else if (authState is LoggedInAuthState) {
              log('signin ------------------ go to the main');
              context.read<AccountBloc>().add(const InitializeAccountEvent());
              context.read<FriendsBloc>().add(const InitializeFriendsEvent());
              context
                  .read<NotificationBloc>()
                  .add(const InitializeNotificationEvent());
              AutoRouter.of(context).replace(const MainRouter());
            }
          },
          builder: (context, authState) {
            // Loading screen.
            if (authState is LoadingAuthState ||
                authState is LoggedInAuthState) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: LoadingScreen(
                  loadingText: AppLocalizations.of(context)!.loading,
                ),
              );
            }

            // Sign in screen layout.
            else {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                  backgroundColor: backgroundTheme.color,
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
                                  text: AppLocalizations.of(context)!.signIn,
                                  fontSize: 27.sp,
                                  color: textTheme.color,
                                ),
                                CustomTextButton(
                                  text: AppLocalizations.of(context)!.register,
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
                              hintText: AppLocalizations.of(context)!.email,
                            ),
                            SizedBox(height: 20.h),
                            CustomField(
                              controller: passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              obscureText: true,
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              text: AppLocalizations.of(context)!.signIn,
                              onTap: () {
                                log('signin ------------------ sign in button pressed');

                                final bool isInternetConnected = context
                                    .read<InternetConnectionBloc>()
                                    .state is ConnectedInternetConnectionState;

                                if (isInternetConnected) {
                                  final String email = emailController.text;
                                  final String password =
                                      passwordController.text;

                                  const int minSymbols = 6;
                                  const int maxSymbols = 55;

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
                                        lastValidation: true,
                                        minSymbols: minSymbols,
                                        maxSymbols: maxSymbols,
                                        validationForbiddenSymbolsText:
                                            '${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.password.toLowerCase()}',
                                        validationEmptyText:
                                            '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.password}',
                                        validationToManySymbolsText:
                                            '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.wordIs} $maxSymbols ${AppLocalizations.of(context)!.symbols}',
                                        validationNotEnoughtSymbolsText:
                                            '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.wordIs} $minSymbols ${AppLocalizations.of(context)!.symbols}',
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
                            SizedBox(height: 35.h),
                            const LogInFormSeparator(),
                            SizedBox(height: 35.h),
                            CustomOutlinedButton(
                              text: AppLocalizations.of(context)!
                                  .signInAnonymously,
                              textColor: buttonTheme.textColor3,
                              border: buttonTheme.border2,
                              onTap: () {
                                log('signin ------------------ sign in anonymously button pressed');

                                final bool isInternetConnected = context
                                    .read<InternetConnectionBloc>()
                                    .state is ConnectedInternetConnectionState;

                                if (isInternetConnected) {
                                  context
                                      .read<AuthBloc>()
                                      .add(const LogInAnonymouslyAuthEvent());
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
                            SizedBox(height: 20.h),
                            CustomIconOutlinedButton(
                              text: AppLocalizations.of(context)!
                                  .signInWithGoogle,
                              textColor: buttonTheme.textColor3,
                              border: buttonTheme.border2,
                              svgPicture: SvgPicture.asset(
                                Svgs.gogle,
                                width: 28.w,
                                height: 28.w,
                              ),
                              onTap: () {
                                log('signin ------------------ sign in with google button pressed');

                                final bool isInternetConnected = context
                                    .read<InternetConnectionBloc>()
                                    .state is ConnectedInternetConnectionState;

                                if (isInternetConnected) {
                                  context
                                      .read<AuthBloc>()
                                      .add(const LogInWithGoogleAuthEvent());
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

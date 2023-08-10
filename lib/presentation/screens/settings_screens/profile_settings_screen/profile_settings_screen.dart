import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/common/errors/profile_avatar_error.dart';
import 'package:game/common/utils/string_extension.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_bloc.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_event.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_state.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/widgets/custom_avatar.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/custom_popups/show_notification_popup.dart';
import 'package:game/presentation/widgets/custom_fields/custom_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocProvider(
      create: (context) => FormValidationBloc(),
      child: BlocListener<ProfileAvatarBloc, ProfileAvatarState>(
        listener: (context, profileAvatarState) {
          if (profileAvatarState is ErrorProfileAvatarState) {
            // Checks if an error occurs and if error message has to be shown.
            final ProfileAvatarError profileAvatarError =
                profileAvatarState.profileAvatarError;
            final bool showPopupWithError =
                profileAvatarError is ProfileAvatarErrorSelectingPhoto;

            // Displays an error message if needed.
            if (showPopupWithError) {
              showNotificationPopUp(
                context: context,
                dialogTitle: profileAvatarError.errorTitle,
                dialogContent: profileAvatarError.errorText,
                buttonText: AppLocalizations.of(context)!.ok,
              );
            }
          }
        },
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, accountState) {
            // Displays an acoount error message if an error occurs.
            if (accountState is ErrorAccountState) {
              log('account error profile settings');
              final AccountError accountError = accountState.accountError;
              final bool showPopupWithError =
                  accountError is AccountErrorLoginIsUsed;

              // Displays an error message.
              if (showPopupWithError) {
                showNotificationPopUp(
                  context: context,
                  dialogTitle: accountError.errorTitle,
                  dialogContent: accountError.errorText,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              } else {
                showNotificationPopUp(
                  context: context,
                  dialogTitle: AppLocalizations.of(context)!.error,
                  dialogContent: AppLocalizations.of(context)!
                      .somethingWentWrongPleaseTryAgain,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              }
            }
          },
          builder: (context, accountState) {
            // Shows loading if an account data was not loaded.
            if (accountState is! LoadedAccountState) {
              return LoadingScreen(
                loadingText: AppLocalizations.of(context)!.loading,
              );
            }

            // Profile settings screen layoyt.
            else {
              final UserAccount userAccount = accountState.getUserAccount()!;

              final TextEditingController usernameController =
                  TextEditingController(
                text: userAccount.username,
              );
              final TextEditingController loginController =
                  TextEditingController(
                text: userAccount.login,
              );

              return BlocListener<FormValidationBloc, FormValidationState>(
                listener: (context, validationState) {
                  // Saves profile changes.
                  if (validationState is ValidatedFormValidationState) {
                    final String newUsername = usernameController.text;
                    final String newLogin = loginController.text;

                    if (newUsername != userAccount.username) {
                      log('start updating username in layout');

                      context.read<AccountBloc>().add(
                            ChangeUsernameAccountEvent(
                              newUsername: newUsername,
                            ),
                          );
                    }

                    if (newLogin != userAccount.login) {
                      log('start updating login in layout');

                      context.read<AccountBloc>().add(
                            ChangeLoginAccountEvent(
                              newLogin: newLogin,
                            ),
                          );
                    }
                  }
                },
                child: Scaffold(
                  backgroundColor: backgroundTheme.color,
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
                        CustomAvatar(
                          avatarLink: userAccount.avatarLink,
                          size: 100.w,
                        ),
                        SizedBox(height: 12.h),
                        CustomTextButton(
                          text: AppLocalizations.of(context)!.setNewPhoto,
                          onTap: () {
                            final bool isInternetConnected = context
                                .read<InternetConnectionBloc>()
                                .state is ConnectedInternetConnectionState;

                            if (isInternetConnected) {
                              context
                                  .read<ProfileAvatarBloc>()
                                  .add(const SetNewPhotoProfileAvatarEvent());
                            } else {
                              showNotificationPopUp(
                                context: context,
                                dialogTitle:
                                    AppLocalizations.of(context)!.disconnected,
                                dialogContent: AppLocalizations.of(context)!
                                    .thereIsNoInternetConnection,
                                buttonText: AppLocalizations.of(context)!.ok,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 35.h),
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
                        CustomButton(
                          text: AppLocalizations.of(context)!.saveChanges,
                          onTap: () {
                            final bool isInternetConnected = context
                                .read<InternetConnectionBloc>()
                                .state is ConnectedInternetConnectionState;

                            if (isInternetConnected) {
                              log(isInternetConnected.toString());
                              final String newUsername =
                                  usernameController.text;
                              final String newLogin = loginController.text;

                              const int minSymbols = 3;
                              const int maxSymbols = 15;

                              // Validates a username.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: newUsername,
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
                                    text: newLogin,
                                    lastValidation: true,
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

                              log('end validation events');
                            } else {
                              showNotificationPopUp(
                                context: context,
                                dialogTitle:
                                    AppLocalizations.of(context)!.disconnected,
                                dialogContent: AppLocalizations.of(context)!
                                    .thereIsNoInternetConnection,
                                buttonText: AppLocalizations.of(context)!.ok,
                              );
                            }
                          },
                        ),
                        const Spacer(),
                        CustomOutlinedButton(
                          text: AppLocalizations.of(context)!.logOut,
                          textColor: buttonTheme.textColor4,
                          border: buttonTheme.border3,
                          onTap: () {
                            log('profile settings ------------------ log out button pressed');

                            context.read<NotificationBloc>().add(
                                const StopListenUpdatesNotificationEvent());
                            context
                                .read<FriendsBloc>()
                                .add(const StopListenUpdatesFriendsEvent());

                            context
                                .read<AuthBloc>()
                                .add(const LogOutAuthEvent());

                            context
                                .read<AccountBloc>()
                                .add(const LogOutAccountEvent());
                          },
                        ),
                      ],
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

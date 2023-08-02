import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/popups/show_notification_popup.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, accountState) {
        // Displays an acoount error message if an error occurs.
        if (accountState is ErrorAccountState) {
          log('account error profile settings');
          final AccountError accountError = accountState.accountError;
          final bool showPopupWithError =
              accountError is AccountErrorLoginIsUsed;

          // Displays an error message.
          if (showPopupWithError) {
            showNotificationDialog(
              context: context,
              dialogTitle: accountError.errorTitle,
              dialogContent: accountError.errorText,
              buttonText: AppLocalizations.of(context)!.ok,
            );
          } else {
            showNotificationDialog(
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
          final TextEditingController loginController = TextEditingController(
            text: userAccount.login,
          );

          return Scaffold(
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
                    text: AppLocalizations.of(context)!.setNewPhoto,
                    onTap: () {
                      //
                      //
                      //
                      //
                      //
                      //
                    },
                  ),
                  SizedBox(height: 35.h),
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
                    },
                  ),
                  const Spacer(),
                  CustomOutlinedButton(
                    text: AppLocalizations.of(context)!.logOut,
                    textColor: buttonTheme.textColor4,
                    border: buttonTheme.border3,
                    onTap: () {
                      log('profile settings ------------------ log out button pressed');
                      context.read<AuthBloc>().add(const LogOutAuthEvent());
                      context
                          .read<AccountBloc>()
                          .add(const LogOutAccountEvent());
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

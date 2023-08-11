import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/errors/friends_error.dart';
import 'package:game/common/utils/error_localization_convertor.dart';
import 'package:game/common/utils/string_extension.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_state.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_fields/custom_field.dart';
import 'package:game/presentation/widgets/custom_popups/show_notification_popup.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = TextEditingController();

    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FormValidationBloc(),
        ),
      ],
      child: BlocListener<FormValidationBloc, FormValidationState>(
        listener: (context, validationState) {
          // Adds new friend by a login.
          if (validationState is ValidatedFormValidationState) {
            context
                .read<FriendsBloc>()
                .add(AddFriendsEvent(friendLogin: loginController.text));
          }
        },
        child: BlocListener<FriendsBloc, FriendsState>(
          listener: (context, friendsState) {
            if (friendsState is LoadedFriendsState) {
              loginController.clear();

              final isPopUpShown = ModalRoute.of(context)?.isCurrent != true;

              if (!isPopUpShown) {
                showNotificationPopUp(
                  context: context,
                  popUpTitle: AppLocalizations.of(context)!.friendWasAdded,
                  popUpText: AppLocalizations.of(context)!
                      .thisUserWasAddedToYourConnections,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              }
            }

            // Checks if an error occurs and if error message has to be shown.
            if (friendsState is ErrorFriendsState) {
              final FriendsError friendsError = friendsState.friendsError;
              final bool showPopupWithError =
                  friendsError is FriendsErrorThisUserIsAlreadyFriend ||
                      friendsError is FriendsErrorNotExistingUserWithLogin ||
                      friendsError is FriendsErrorCanNotAddYourselfAsFriend;
              final bool showPopupWithBasicSentences =
                  friendsError is! FriendsErrorFriendAdding &&
                      friendsError is! FriendsErrorUnknown;

              // Displays an error message if needed.
              if (showPopupWithError) {
                showNotificationPopUp(
                  context: context,
                  popUpTitle: getLocalizatedError(context, error: friendsError)
                      .errorTitle,
                  popUpText: getLocalizatedError(context, error: friendsError)
                      .errorText,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              } else if (showPopupWithBasicSentences) {
                showNotificationPopUp(
                  context: context,
                  popUpTitle: AppLocalizations.of(context)!.addingFriendError,
                  popUpText: AppLocalizations.of(context)!
                      .somethingWentWrongWhileAddingFriend,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              }
            }
          },
          child: Builder(builder: (context) {
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
                              text: AppLocalizations.of(context)!.addFriend,
                              fontSize: 26.sp,
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              text: AppLocalizations.of(context)!
                                  .enterLoginOfPlayerYouWantToAddAsFriends,
                              color: textTheme.color3,
                              maxLines: 4,
                              textAlign: TextAlign.center,
                            ),
                            const ValidationMessagesList(),
                            CustomField(
                              controller: loginController,
                              hintText: AppLocalizations.of(context)!.login,
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              text: AppLocalizations.of(context)!.wordAdd,
                              onTap: () {
                                final bool isInternetConnected = context
                                    .read<InternetConnectionBloc>()
                                    .state is ConnectedInternetConnectionState;

                                if (isInternetConnected) {
                                  final String login = loginController.text;

                                  const int minSymbols = 3;
                                  const int maxSymbols = 15;

                                  // Validates a login.
                                  context
                                      .read<FormValidationBloc>()
                                      .add(TextFormValidationEvent(
                                        text: login,
                                        maxSymbols: maxSymbols,
                                        minSymbols: minSymbols,
                                        lastValidation: true,
                                        validationForbiddenSymbolsText:
                                            '//${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.login.toLowerCase()}',
                                        validationEmptyText:
                                            '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.login}',
                                        validationToManySymbolsText:
                                            '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $maxSymbols ${AppLocalizations.of(context)!.symbols}',
                                        validationNotEnoughtSymbolsText:
                                            '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $minSymbols ${AppLocalizations.of(context)!.symbols}',
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

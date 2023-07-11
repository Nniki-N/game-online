import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/utils/string_extension.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = TextEditingController();

    return BlocProvider(
      create: (context) => FormValidationBloc(),
      child: BlocListener<FormValidationBloc, FormValidationState>(
        listener: (context, validationState) {
          // Adds new friend by a login.
          if (validationState is ValidatedFormValidationState) {
            //
          }
        },
        child: Builder(builder: (context) {
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
                            text: AppLocalizations.of(context)!.addFriend,
                            fontSize: 26.sp,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            text: AppLocalizations.of(context)!
                                .enterUsernameOfPlayerYouWantToAddAsFriends,
                            color: CustomColors.secondTextColor,
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
                                        '${AppLocalizations.of(context)!.symbols.capitalize()} [] ${AppLocalizations.of(context)!.areForbiddenToUseInThe} ${AppLocalizations.of(context)!.login.toLowerCase()}',
                                    validationEmptyText:
                                        '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.login}',
                                    validationToManySymbolsText:
                                        '${AppLocalizations.of(context)!.maximalLengthOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $maxSymbols ${AppLocalizations.of(context)!.symbols}',
                                    validationNotEnoughtSymbolsText:
                                        '${AppLocalizations.of(context)!.minimalLenghtOf} ${AppLocalizations.of(context)!.login} ${AppLocalizations.of(context)!.wordIs} $minSymbols ${AppLocalizations.of(context)!.symbols}',
                                  ));
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
    );
  }
}

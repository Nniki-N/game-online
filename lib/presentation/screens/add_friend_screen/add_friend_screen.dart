import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_event.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/presentation/widgets/validation_messages_list.dart';

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
                            text: 'Add friend',
                            fontSize: 26.sp,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            text:
                                'Enter username of player you want to add as a friends',
                            color: CustomColors.secondTextColor,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                          ),
                          const ValidationMessagesList(),
                          CustomField(
                            controller: loginController,
                            hintText: 'Login',
                          ),
                          SizedBox(height: 20.h),
                          CustomButton(
                            text: 'Add',
                            onTap: () {
                              final String login = loginController.text;

                              // Validates a login.
                              context
                                  .read<FormValidationBloc>()
                                  .add(TextFormValidationEvent(
                                    text: login,
                                    maxSymbols: 15,
                                    lastValidation: true,
                                    validationForbiddenSymbolsText:
                                        'Symbols [] are forbidden to use in the login',
                                    validationEmptyText:
                                        'Please enter the login',
                                    validationToManySymbolsText:
                                        'Maximal length of the login is 15 symbols',
                                    validationNotEnoughtSymbolsText:
                                        'Minimal lenght of the login is 3 symbols',
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

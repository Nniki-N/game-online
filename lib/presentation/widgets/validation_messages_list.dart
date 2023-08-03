import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_bloc.dart';
import 'package:game/presentation/bloc/form_validation_bloc/form_validation_state.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

class ValidationMessagesList extends StatelessWidget {
  const ValidationMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, validationState) {
        final bool showValidationMessages =
            validationState is FailedFormValidationState &&
                validationState.validationFinished;

        // Shows only if validation ended.
        if (showValidationMessages) {
          final List<String> validationMessages =
              validationState.validationMessages;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: validationMessages.length,
              separatorBuilder: (_, index) => SizedBox(height: 10.h),
              itemBuilder: (_, index) => CustomText(
                text: validationMessages[index],
                maxLines: 3,
                color: textTheme.color4,
              ),
            ),
          );
        } else {
          return SizedBox(height: 35.h);
        }
      },
    );
  }
}

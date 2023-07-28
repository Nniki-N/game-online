import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/domain/entities/language.dart';
import 'package:game/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:game/presentation/bloc/language_bloc/language_state.dart';
import 'package:game/presentation/screens/settings_screens/language_settings_screen/language_list_view_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
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
                CustomText(
                  text: AppLocalizations.of(context)!.language,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 35.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Language.values.length,
                      itemBuilder: (context, index) {
                        return LanguageListViewItem(
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

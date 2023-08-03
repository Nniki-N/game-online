import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameRulesScreen extends StatelessWidget {
  const GameRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

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
                      text: AppLocalizations.of(context)!.gameRules,
                      fontSize: 26.sp,
                    ),
                    SizedBox(height: 15.h),
                    CustomText(
                      text:
                          AppLocalizations.of(context)!.gameRulesText,
                      color: textTheme.color3,
                      maxLines: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

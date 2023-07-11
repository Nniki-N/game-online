import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/settings_screens/appearance_settings_screen/settings_appearance_select_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/switches/custom_switch.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 55.h),
            CustomText(
              text: AppLocalizations.of(context)!.appearance,
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingsAppearanceSelectItem(
                  text: AppLocalizations.of(context)!.light,
                  isSelected: true,
                  onTap: () {
                    //
                  },
                ),
                SizedBox(width: 40.w),
                SettingsAppearanceSelectItem(
                  text: AppLocalizations.of(context)!.dark,
                  isSelected: false,
                  onTap: () {
                    //
                  },
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: AppLocalizations.of(context)!.automatic),
                CustomSwitch(
                  isSelected: true,
                  onChanged: (value) {
                    //
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(
              text: AppLocalizations.of(context)!
                  .setsThemeBasedOnYourDeviceAppearanceMode,
              maxLines: 3,
              fontSize: 14.sp,
              color: CustomColors.secondTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

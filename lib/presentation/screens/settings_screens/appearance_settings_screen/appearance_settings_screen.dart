import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_bloc.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_event.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_state.dart';
import 'package:game/presentation/screens/settings_screens/appearance_settings_screen/settings_appearance_select_item.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_switches/custom_switch.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:game/resources/resources.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocBuilder<AppearanceBloc, AppearanceState>(
      builder: (context, appearanceState) {
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
                      svgPicture: SvgPicture.asset(
                        Svgs.lightThemeMode,
                        width: 95.w,
                      ),
                      isSelected:
                          !(appearanceState as LoadedAppearanceState).isDark,
                      onTap: () {
                        context
                            .read<AppearanceBloc>()
                            .add(const ChangeAppearanceEvent(isDark: false));
                      },
                    ),
                    SizedBox(width: 40.w),
                    SettingsAppearanceSelectItem(
                      text: AppLocalizations.of(context)!.dark,
                      svgPicture: SvgPicture.asset(
                        Svgs.darkThemeMode,
                        width: 95.w,
                      ),
                      isSelected: appearanceState.isDark,
                      onTap: () {
                        context
                            .read<AppearanceBloc>()
                            .add(const ChangeAppearanceEvent(isDark: true));
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
                      isSelected: appearanceState.isAutomatic,
                      onChanged: (value) {
                        context
                            .read<AppearanceBloc>()
                            .add(SetAutomaticAppearanceEvent(
                              isAutomatic: !appearanceState.isAutomatic,
                            ));
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
                  color: textTheme.color3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

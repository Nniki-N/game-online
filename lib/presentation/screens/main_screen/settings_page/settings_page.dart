import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/screens/main_screen/settings_page/settinds_details_button.dart';
import 'package:game/presentation/screens/main_screen/settings_page/settings_profile_container.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
        top: 45.h,
        bottom: 30.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileDetailsContainer(
            onTap: () {
              AutoRouter.of(context).push(const ProfileSettingsRouter());
            },
          ),
          SizedBox(height: 35.h),
          SettingsDetatilsButton(
            text: AppLocalizations.of(context)!.appearance,
            onTap: () {
              AutoRouter.of(context).push(const AppearanceSettingsRouter());
            },
          ),
          SizedBox(height: 15.h),
          SettingsDetatilsButton(
            text: AppLocalizations.of(context)!.language,
            onTap: () {
              AutoRouter.of(context).push(const LanguageSettingsRouter());
            },
          ),
          // SizedBox(height: 25.h),
          // SettingsSlider(
          //   text: AppLocalizations.of(context)!.backgroundMusic,
          //   currentValue: 70,
          //   onCanged: (value) {
          //     //
          //   },
          // ),
          // SizedBox(height: 15.h),
          // SettingsSlider(
          //   text: AppLocalizations.of(context)!.soundEffects,
          //   currentValue: 30,
          //   onCanged: (value) {
          //     //
          //   },
          // ),
          const Spacer(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final bool isAnonymousUser = authState.isAnonymousUser();

              return !isAnonymousUser
                  ? const SizedBox.shrink()
                  : CustomOutlinedButton(
                      text: AppLocalizations.of(context)!.register,
                      onTap: () {
                        AutoRouter.of(context).push(
                          const SettingsRegisterRouter(),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

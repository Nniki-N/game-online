import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide IconTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotExistingScreen extends StatelessWidget {
  const NotExistingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return Scaffold(
      backgroundColor: backgroundTheme.color,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Svgs.alert,
                    height: 100.h,
                    colorFilter: ColorFilter.mode(
                      iconTheme.color2,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  CustomText(
                    text: AppLocalizations.of(context)!.thisPageDoesNotExist,
                    fontSize: 26.sp,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 45.h,
            left: 30.w,
            child: Row(
              children: [
                CustomButtonBack(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

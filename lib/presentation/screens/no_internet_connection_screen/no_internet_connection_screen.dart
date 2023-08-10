import 'package:flutter/material.dart' hide IconTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return Scaffold(
      backgroundColor: backgroundTheme.color,
      body: Center(
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
              text: AppLocalizations.of(context)!.thereIsNoInternetConnection,
              fontSize: 26.sp,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

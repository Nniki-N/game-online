import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/settings_item_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class SettingsDetatilsButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SettingsDetatilsButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsItemTheme settingsItemTheme =
        Theme.of(context).extension<SettingsItemTheme>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 15.w,
        ),
        decoration: BoxDecoration(
          color: settingsItemTheme.backgroundColor,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: text,
              fontSize: 14.sp,
            ),
            SvgPicture.asset(
              Svgs.arrowForward,
              width: 18.w,
              colorFilter: ColorFilter.mode(
                settingsItemTheme.foregroundColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

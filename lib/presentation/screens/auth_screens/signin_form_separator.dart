import 'package:flutter/material.dart' hide IconTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/resources/resources.dart';

class LogInFormSeparator extends StatelessWidget {
  const LogInFormSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.h,
            color: iconTheme.color3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SvgPicture.asset(
            Svgs.signInSeparator,
            colorFilter: ColorFilter.mode(
              iconTheme.color3,
              BlendMode.srcIn,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1.h,
            color: iconTheme.color3,
          ),
        ),
      ],
    );
  }
}

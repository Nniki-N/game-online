import 'package:flutter/material.dart' hide ButtonTheme, IconTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/resources/resources.dart';

/// A custom text button with an icon.
///
/// All fields are set by default.
///
/// [color] is a color of a button. By default is ButtonTheme.backgroundColor.
///
/// [height] is a height of a button. By default is 40.h.
///
/// [width] is a width of a button. By default is 40.w.
///
/// [borderRadius] is a border radius of a button. By default is ButtonTheme.borderRadius2.
///
/// [svgPicture] is an icon that is positioned on the center of the button.
///
/// [onTap] is a function that batton executes. By default is null.
///
class CustomButtonBack extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final SvgPicture? svgPicture;
  final VoidCallback? onTap;

  const CustomButtonBack({
    super.key,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.svgPicture,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width ?? 40.w,
        height: height ?? 40.w,
        decoration: BoxDecoration(
          color: color ?? buttonTheme.backgroundColor,
          borderRadius: borderRadius ?? buttonTheme.borderRadius2,
        ),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        child: svgPicture ??
            SvgPicture.asset(
              Svgs.arrowBack,
              colorFilter: ColorFilter.mode(
                iconTheme.color4,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }
}

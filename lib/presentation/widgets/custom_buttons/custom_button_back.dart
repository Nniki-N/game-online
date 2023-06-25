import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/resources/resources.dart';

/// A custom text button with an icon.
///
/// All fields are set by default.
///
/// [color] is a color of a button and a text. By default is CustomColors.mainColor
///
/// [height] is a height of a button. By default is 40.h.
///
/// [width] is a width of a button. By default is 40.w.
///
/// [borderRadius] is a border radius of a button. By default is 8.w.
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 40.w,
        height: height ?? 40.w,
        decoration: BoxDecoration(
            color: color ?? CustomColors.mainColor,
            borderRadius: borderRadius ?? BorderRadius.circular(8.w)),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        child: svgPicture ??
            SvgPicture.asset(
              Svgs.arrowBackIcon,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

/// A custom flat button.
///
/// Only [text] has to be set, another fields are set by default.
///
/// [backgroundColor] is a color of a button. By default is CustomColors.mainColor.
///
/// [height] is a height of a button. By default is 50.h.
///
/// [width] is a width of a button. By default is double.infinity.
///
/// [borderRadius] is a border radius of a button. By default is 10.h.
///
/// [text] is a text that describes meaning of the button.
///
/// [foregroundColor] is a color of a text. By default is white.
///
/// [fontSize] is a font size of a text. By default is 17.sp.
///
/// [fontWeight] is a font weight of a text. By default is medium.
///
/// [onTap] is a function that batton executes. By default is null.
///
class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.borderRadius,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50.h,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.mainColor,
          borderRadius: borderRadius ?? BorderRadius.circular(10.h),
        ),
        child: CustomText(
          text: text,
          textAlign: TextAlign.center,
          fontSize: fontSize ?? 17.sp,
          color: foregroundColor ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

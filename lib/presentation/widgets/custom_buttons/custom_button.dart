import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

/// A custom flat button.
///
/// Only [text] has to be set, another fields are set by default.
///
/// [backgroundColor] is a color of a button. By default is ButtonTheme.backgroundColor.
///
/// [height] is a height of a button. By default is 50.h.
///
/// [width] is a width of a button. By default is double.infinity.
///
/// [borderRadius] is a border radius of a button. By default is ButtonTheme.borderRadius.
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
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height ?? 50.h,
        // width: width ?? double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        constraints: BoxConstraints(
          minWidth: width ?? 80.w,
          maxWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? buttonTheme.backgroundColor,
          borderRadius: borderRadius ?? buttonTheme.borderRadius,
        ),
        child: CustomText(
          text: text,
          textAlign: TextAlign.center,
          fontSize: fontSize ?? 17.sp,
          color: foregroundColor ?? buttonTheme.textColor,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

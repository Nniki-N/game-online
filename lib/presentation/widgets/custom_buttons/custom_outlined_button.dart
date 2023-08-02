import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

/// A custom outlined button.
///
/// Only [text] has to be set, another fields are set by default.
///
/// [textColor] is a color of and a text. By default is ButtonTheme.textColor4.
///
/// [border] is a width of a button border. By default is ButtonTheme.border2.
///
/// [height] is a height of a button. By default is 50.h.
///
/// [width] is a width of a button. By default is double.infinity.
///
/// [borderRadius] is a border radius of a button. By default is ButtonTheme.borderRadius.
///
/// [text] is a text that describes meaning of the button.
///
/// [fontSize] is a font size of a text. By default is 17.sp.
///
/// [fontWeight] is a font weight of a text. By default is medium.
///
/// [onTap] is a function that batton executes. By default is null.
///
class CustomOutlinedButton extends StatelessWidget {
  final Color? textColor;
  final Border? border;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CustomOutlinedButton({
    super.key,
    this.textColor,
    this.border,
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
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: border ?? buttonTheme.border,
          borderRadius: borderRadius ?? buttonTheme.borderRadius,
        ),
        child: CustomText(
          text: text,
          textAlign: TextAlign.center,
          fontSize: fontSize ?? 17.sp,
          color: textColor ?? buttonTheme.textColor2,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

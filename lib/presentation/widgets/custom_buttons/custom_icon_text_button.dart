import 'package:flutter/material.dart' hide ButtonTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';

/// A custom text button with an icon.
///
/// Only [text], [svgPicture], [spaceBetween] have to be set, another fields are set by default.
///
/// [foregroundColor] is a color of a text. By default is ButtonTheme.textColor.
///
/// [padding] is a padding that sets the space around the button. By defauld is EdgeInsets.zero.
///
/// [svgPicture] is an icon that is positioned on the left side of the button.
///
/// [spaceBetween] is a space between an icon and a text.
///
/// [text] is a text that describes meaning of the button.
///
/// [fontSize] is a font size of a text. By default is 17.sp.
///
/// [fontWeight] is a font weight of a text. By default is medium.
///
/// [onTap] is a function that batton executes. By default is null.
///
class CustomIconTextButton extends StatelessWidget {
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final SvgPicture svgPicture;
  final double spaceBetween;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final VoidCallback? onTap;

  const CustomIconTextButton({
    super.key,
    this.foregroundColor,
    this.padding,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.onTap,
    required this.svgPicture,
    required this.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonTheme buttonTheme = Theme.of(context).extension<ButtonTheme>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            svgPicture,
            SizedBox(width: spaceBetween),
            CustomText(
              text: text,
              fontSize: fontSize ?? 17.sp,
              color: foregroundColor ?? buttonTheme.textColor2,
              fontWeight: fontWeight ?? FontWeight.w500,
              textDecoration: textDecoration,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// A custom text button with an icon.
///
/// Only [text] has to be set, all other fields are set by default.
///
/// [text] is  text.
///
/// [textAlign] defines how the text should be aligned horizontally.
///
/// [maxLines] defines max lines of a text.
///
/// [color] is a color of a button. By default is TextTheme.color.
///
/// [fontSize] is a font size of a text. By default is 17.sp.
///
/// [fontWeight] is a font weight of a text. By default is regular.
class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;

  const CustomText({
    super.key,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;

    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: color ?? textTheme.color,
        fontSize: fontSize ?? 17.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: textDecoration,
      ),
    );
  }
}

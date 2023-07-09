import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

/// A custom text button.
/// 
/// Only [text] has to be set, another fields are set by default.
/// 
/// [color] is a color of a text. By default is CustomColors.mainColor
/// 
/// [padding] is a padding that sets the space around the button. By defauld is EdgeInsets.zero.
/// 
/// [text] is a text that describes meaning of the button. 
/// 
/// [fontSize] is a font size of a text. By default is 17.sp.
/// 
/// [fontWeight] is a font weight of a text. By default is medium.
/// 
/// [onTap] is a function that batton executes. By default is null.
/// 
class CustomTextButton extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CustomTextButton({
    super.key,
    this.color,
    this.padding,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CustomText(
          text: text,
          fontSize: fontSize ?? 17.sp,
          color: color ?? CustomColors.mainColor,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

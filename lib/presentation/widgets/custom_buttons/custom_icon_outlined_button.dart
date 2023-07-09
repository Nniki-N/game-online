import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

/// A custom outlined button with an icon.
/// 
/// Only [text] and [svgPicture] have to be set, another fields are set by default.
/// 
/// [color] is a color of a button and a text. By default is CustomColors.mainColor
/// 
/// [borderWidth] is a width of a button border. By default is 2.h.
/// 
/// [height] is a height of a button. By default is 50.h.
/// 
/// [width] is a width of a button. By default is double.infinity.
/// 
/// [borderRadius] is a border radius of a button. By default is 10.h.
/// 
/// [svgPicture] is an icon that is positioned on the left side of the button.
/// 
/// [text] is a text that describes meaning of the button. 
/// 
/// [fontSize] is a font size of a text. By default is 17.sp.
/// 
/// [fontWeight] is a font weight of a text. By default is medium.
/// 
/// [onTap] is a function that batton executes. By default is null.
/// 
class CustomIconOutlinedButton extends StatelessWidget {
  final Color? color;
  final double? borderWidth;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final SvgPicture svgPicture;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CustomIconOutlinedButton({
    super.key,
    this.color,
    this.borderWidth,
    this.height,
    this.width,
    this.borderRadius,
    required this.svgPicture,
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
      child: Container(
        height: height ?? 50.h,
        width: width ?? double.infinity,
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: color ?? CustomColors.mainColor,
            width: borderWidth ?? 2.h,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(10.h),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgPicture,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: CustomText(
                  text: text,
                  textAlign: TextAlign.center,
                  fontSize: fontSize ?? 17.sp,
                  color: color ?? CustomColors.mainColor,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: svgPicture.width, height: svgPicture.height),
          ],
        ),
      ),
    );
  }
}

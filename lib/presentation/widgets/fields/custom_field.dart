import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';

/// A custom form field.
///
/// Only [controller] and [hintText] have to be set, another
/// fields are set by default.
///
/// [controller] is a controller that controls the text being edited.
///
/// [hintText] is a text that suggests what sort of input the field accepts.
///
/// [obscureText] is a variable that defines if the field has to be obscured.
///
/// [autoCorrect] is a variable that defines if the field corrects a text automatically.
///
/// [enableSuggestions] is a variable that defines if the field shows suggestions.
///
/// [keyboardType] is a variable that decides keyboard type.
///
class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autoCorrect;
  final bool enableSuggestions;
  final TextInputType keyboardType;

  const CustomField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.autoCorrect = false,
    this.enableSuggestions = false,
    this.keyboardType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CustomColors.backgroundLightGrayColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        enableSuggestions: enableSuggestions,
        keyboardType: keyboardType,
        // The field decoration.
        textAlign: TextAlign.left,
        cursorColor: CustomColors.mainColor,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: CustomColors.fieldGreyTextColor,
          ),
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
        ),
      ),
    );
  }
}

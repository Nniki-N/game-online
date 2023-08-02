import 'package:flutter/material.dart';

class FieldTheme extends ThemeExtension<FieldTheme> {
  final Color backgroundColor;
  final Color textColor;
  final Color hintextColor;
  final Color cursorColor;
  final BorderRadius borderRadius;

  FieldTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.hintextColor,
    required this.cursorColor,
    required this.borderRadius,
  });

  @override
  ThemeExtension<FieldTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? hintextColor,
    Color? cursorColor,
    BorderRadius? borderRadius,
  }) {
    return FieldTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      hintextColor: hintextColor ?? this.hintextColor,
      cursorColor: cursorColor ?? this.cursorColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<FieldTheme> lerp(
    covariant ThemeExtension<FieldTheme>? other,
    double t,
  ) {
    if (other is! FieldTheme) {
      return this;
    }

    return FieldTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      hintextColor:
          Color.lerp(hintextColor, other.hintextColor, t) ?? hintextColor,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t) ?? cursorColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
    );
  }
}

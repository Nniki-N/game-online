import 'package:flutter/material.dart';

class PopUpMenuTheme extends ThemeExtension<PopUpMenuTheme> {
  final Color backgroundColor;
  final Color textColor;
  final Color separatorColor;
  final Color shadowColor;
  final BorderRadius borderRadius;

  PopUpMenuTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.separatorColor,
    required this.shadowColor,
    required this.borderRadius,
  });

  @override
  ThemeExtension<PopUpMenuTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? separatorColor,
    Color? shadowColor,
    BorderRadius? borderRadius,
  }) {
    return PopUpMenuTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      separatorColor: separatorColor ?? this.separatorColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<PopUpMenuTheme> lerp(
    covariant ThemeExtension<PopUpMenuTheme>? other,
    double t,
  ) {
    if (other is! PopUpMenuTheme) {
      return this;
    }

    return PopUpMenuTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      separatorColor:
          Color.lerp(separatorColor, other.separatorColor, t) ?? separatorColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
    );
  }
}

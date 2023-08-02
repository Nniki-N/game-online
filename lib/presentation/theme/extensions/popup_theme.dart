import 'package:flutter/material.dart';

class PopUpTheme extends ThemeExtension<PopUpTheme> {
  final Color backgroundColor;
  final Color titleColor;
  final Color textColor;
  final Color overlayColor;
  final BorderRadius borderRadius;

  PopUpTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.titleColor,
    required this.overlayColor,
    required this.borderRadius,
  });

  @override
  ThemeExtension<PopUpTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? titleColor,
    Color? overlayColor,
    BorderRadius? borderRadius,
  }) {
    return PopUpTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      titleColor: titleColor ?? this.titleColor,
      overlayColor: overlayColor ?? this.overlayColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<PopUpTheme> lerp(
    covariant ThemeExtension<PopUpTheme>? other,
    double t,
  ) {
    if (other is! PopUpTheme) {
      return this;
    }

    return PopUpTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      titleColor: Color.lerp(titleColor, other.titleColor, t) ?? titleColor,
      overlayColor:
          Color.lerp(overlayColor, other.overlayColor, t) ?? overlayColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
    );
  }
}

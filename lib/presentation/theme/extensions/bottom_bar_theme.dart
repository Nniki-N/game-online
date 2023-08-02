import 'package:flutter/material.dart';

class BottomBarTheme extends ThemeExtension<BottomBarTheme> {
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  BottomBarTheme({
    required this.backgroundColor,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  ThemeExtension<BottomBarTheme> copyWith({
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return BottomBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  @override
  ThemeExtension<BottomBarTheme> lerp(
    covariant ThemeExtension<BottomBarTheme>? other,
    double t,
  ) {
    if (other is! BottomBarTheme) {
      return this;
    }

    return BottomBarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      activeColor: Color.lerp(activeColor, other.activeColor, t) ?? activeColor,
      inactiveColor:
          Color.lerp(inactiveColor, other.inactiveColor, t) ?? inactiveColor,
    );
  }
}

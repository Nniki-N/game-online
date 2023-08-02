import 'package:flutter/material.dart';

class SwitchTheme extends ThemeExtension<SwitchTheme> {
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final Color inactiveBackgroundColor;
  final Color inactiveForegroundColor;

  SwitchTheme({
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.inactiveBackgroundColor,
    required this.inactiveForegroundColor,
  });

  @override
  ThemeExtension<SwitchTheme> copyWith({
    Color? activeBackgroundColor,
    Color? activeForegroundColor,
    Color? inactiveBackgroundColor,
    Color? inactiveForegroundColor,
  }) {
    return SwitchTheme(
      activeBackgroundColor:
          activeBackgroundColor ?? this.activeBackgroundColor,
      activeForegroundColor:
          activeForegroundColor ?? this.activeForegroundColor,
      inactiveBackgroundColor:
          inactiveBackgroundColor ?? this.inactiveBackgroundColor,
      inactiveForegroundColor:
          inactiveForegroundColor ?? this.inactiveForegroundColor,
    );
  }

  @override
  ThemeExtension<SwitchTheme> lerp(
    covariant ThemeExtension<SwitchTheme>? other,
    double t,
  ) {
    if (other is! SwitchTheme) {
      return this;
    }

    return SwitchTheme(
      activeBackgroundColor:
          Color.lerp(activeBackgroundColor, other.activeBackgroundColor, t) ??
              activeBackgroundColor,
      activeForegroundColor:
          Color.lerp(activeForegroundColor, other.activeForegroundColor, t) ??
              activeForegroundColor,
      inactiveBackgroundColor: Color.lerp(
              inactiveBackgroundColor, other.inactiveBackgroundColor, t) ??
          inactiveBackgroundColor,
      inactiveForegroundColor: Color.lerp(
              inactiveForegroundColor, other.inactiveForegroundColor, t) ??
          inactiveForegroundColor,
    );
  }
}

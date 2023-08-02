import 'package:flutter/material.dart';

class SettingsItemTheme extends ThemeExtension<SettingsItemTheme> {
  final Color backgroundColor;
  final Color foregroundColor;

  SettingsItemTheme({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  ThemeExtension<SettingsItemTheme> copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return SettingsItemTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  ThemeExtension<SettingsItemTheme> lerp(
    covariant ThemeExtension<SettingsItemTheme>? other,
    double t,
  ) {
    if (other is! SettingsItemTheme) {
      return this;
    }

    return SettingsItemTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t) ??
          foregroundColor,
    );
  }
}

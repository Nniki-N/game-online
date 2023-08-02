import 'package:flutter/material.dart';

class RadioButtonTheme extends ThemeExtension<RadioButtonTheme> {
  final Color inactivColor;
  final Color activColor;

  RadioButtonTheme({
    required this.inactivColor,
    required this.activColor,
  });

  @override
  ThemeExtension<RadioButtonTheme> copyWith({
    Color? inactivColor,
    Color? activColor,
  }) {
    return RadioButtonTheme(
      inactivColor: inactivColor ?? this.inactivColor,
      activColor: activColor ?? this.activColor,
    );
  }

  @override
  ThemeExtension<RadioButtonTheme> lerp(
    covariant ThemeExtension<RadioButtonTheme>? other,
    double t,
  ) {
    if (other is! RadioButtonTheme) {
      return this;
    }

    return RadioButtonTheme(
      inactivColor:
          Color.lerp(inactivColor, other.inactivColor, t) ?? inactivColor,
      activColor: Color.lerp(activColor, other.activColor, t) ?? activColor,
    );
  }
}

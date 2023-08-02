import 'package:flutter/material.dart';

class ChipsRowTheme extends ThemeExtension<ChipsRowTheme> {
  final Color backgroundColor;
  final Color textColor;

  ChipsRowTheme({
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  ThemeExtension<ChipsRowTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
  }) {
    return ChipsRowTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<ChipsRowTheme> lerp(
    covariant ThemeExtension<ChipsRowTheme>? other,
    double t,
  ) {
    if (other is! ChipsRowTheme) {
      return this;
    }

    return ChipsRowTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
    );
  }
}

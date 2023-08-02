import 'package:flutter/material.dart';

class TextTheme extends ThemeExtension<TextTheme> {
  final Color color;
  final Color color2;
  final Color color3;
  final Color color4;
  // final Color color5;
  // final Color color6;

  TextTheme({
    required this.color,
    required this.color2,
    required this.color3,
    required this.color4,
    // required this.color5,
    // required this.color6,
  });

  @override
  ThemeExtension<TextTheme> copyWith({
    Color? color,
    Color? color2,
    Color? color3,
    Color? color4,
    // Color? color5,
    // Color? color6,
  }) {
    return TextTheme(
      color: color ?? this.color,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      color4: color4 ?? this.color4,
      // color5: color5 ?? this.color5,
      // color6: color6 ?? this.color6,
    );
  }

  @override
  ThemeExtension<TextTheme> lerp(
    covariant ThemeExtension<TextTheme>? other,
    double t,
  ) {
    if (other is! TextTheme) {
      return this;
    }

    return TextTheme(
      color: Color.lerp(color, other.color, t) ?? color,
      color2: Color.lerp(color2, other.color2, t) ?? color2,
      color3: Color.lerp(color3, other.color3, t) ?? color3,
      color4: Color.lerp(color4, other.color4, t) ?? color4,
      // color5: Color.lerp(color5, other.color5, t) ?? color5,
      // color6: Color.lerp(color6, other.color6, t) ?? color6,
    );
  }
}

import 'package:flutter/material.dart';

class BackgroundTheme extends ThemeExtension<BackgroundTheme> {
  final Color color;
  final Color color2;
  // final Color color3;
  // final Color color4;
  // final Color color5;

  BackgroundTheme({
    required this.color,
    required this.color2,
    // required this.color3,
    // required this.color4,
    // required this.color5,
  });

  @override
  ThemeExtension<BackgroundTheme> copyWith({
    Color? color,
    Color? color2,
    // Color? color3,
    // Color? color4,
    // Color? color5,
  }) {
    return BackgroundTheme(
      color: color ?? this.color,
      color2: color2 ?? this.color2,
      // color3: color3 ?? this.color3,
      // color4: color4 ?? this.color4,
      // color5: color5 ?? this.color5,
    );
  }

  @override
  ThemeExtension<BackgroundTheme> lerp(
    covariant ThemeExtension<BackgroundTheme>? other,
    double t,
  ) {
    if (other is! BackgroundTheme) {
      return this;
    }

    return BackgroundTheme(
      color: Color.lerp(color, other.color, t) ?? color,
      color2: Color.lerp(color2, other.color2, t) ?? color2,
      // color3: Color.lerp(color3, other.color3, t) ?? color3,
      // color4: Color.lerp(color4, other.color4, t) ?? color4,
      // color5: Color.lerp(color5, other.color5, t) ?? color5,
    );
  }
}

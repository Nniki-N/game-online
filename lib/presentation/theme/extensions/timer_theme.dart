import 'package:flutter/material.dart';

class TimerTheme extends ThemeExtension<TimerTheme> {
  final Color color;

  TimerTheme({
    required this.color,
  });

  @override
  ThemeExtension<TimerTheme> copyWith({
    Color? color,
  }) {
    return TimerTheme(
      color: color ?? this.color,
    );
  }

  @override
  ThemeExtension<TimerTheme> lerp(
    covariant ThemeExtension<TimerTheme>? other,
    double t,
  ) {
    if (other is! TimerTheme) {
      return this;
    }

    return TimerTheme(
      color: Color.lerp(color, other.color, t) ?? color,
    );
  }
}

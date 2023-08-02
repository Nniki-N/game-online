import 'package:flutter/material.dart';

class GameFieldTheme extends ThemeExtension<GameFieldTheme> {
  final Color backgroundColor;
  final Color separatorColor;
  final BorderRadius borderRadius;

  GameFieldTheme({
    required this.backgroundColor,
    required this.separatorColor,
    required this.borderRadius,
  });

  @override
  ThemeExtension<GameFieldTheme> copyWith({
    Color? backgroundColor,
    Color? separatorColor,
    BorderRadius? borderRadius,
  }) {
    return GameFieldTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      separatorColor: separatorColor ?? this.separatorColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<GameFieldTheme> lerp(
    covariant ThemeExtension<GameFieldTheme>? other,
    double t,
  ) {
    if (other is! GameFieldTheme) {
      return this;
    }

    return GameFieldTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      separatorColor:
          Color.lerp(separatorColor, other.separatorColor, t) ?? separatorColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
    );
  }
}

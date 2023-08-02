import 'package:flutter/material.dart';

@immutable
class ButtonTheme extends ThemeExtension<ButtonTheme> {
  // Background color.
  final Color backgroundColor;
  final Color backgroundColor2;

  // Text colors.
  final Color textColor;
  final Color textColor2;
  final Color textColor3;
  final Color textColor4;

  // Icon colors.
  // final Color iconColor;
  // final Color iconColor2;

  // Border width and radiuses.
  final Border border;
  final Border border2;
  final Border border3;
  final BorderRadius borderRadius;
  final BorderRadius borderRadius2;

  const ButtonTheme({
    required this.backgroundColor,
    required this.backgroundColor2,
    required this.textColor,
    required this.textColor2,
    required this.textColor3,
    required this.textColor4,
    // required this.iconColor,
    // required this.iconColor2,
    required this.border,
    required this.border2,
    required this.border3,
    required this.borderRadius,
    required this.borderRadius2,
  });

  @override
  ThemeExtension<ButtonTheme> copyWith({
    Color? backgroundColor,
    Color? backgroundColor2,
    Color? textColor,
    Color? textColor2,
    Color? textColor3,
    Color? textColor4,
    // Color? iconColor,
    // Color? iconColor2,
    Border? border,
    Border? border2,
    Border? border3,
    BorderRadius? borderRadius,
    BorderRadius? borderRadius2,
  }) {
    return ButtonTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
      textColor: textColor ?? this.textColor,
      textColor2: textColor2 ?? this.textColor2,
      textColor3: textColor3 ?? this.textColor3,
      textColor4: textColor4 ?? this.textColor4,
      // iconColor: iconColor ?? this.iconColor,
      // iconColor2: iconColor2 ?? this.iconColor2,
      border: border ?? this.border,
      border2: border2 ?? this.border2,
      border3: border3 ?? this.border3,
      borderRadius: borderRadius ?? this.borderRadius,
      borderRadius2: borderRadius2 ?? this.borderRadius2,
    );
  }

  @override
  ThemeExtension<ButtonTheme> lerp(
    covariant ThemeExtension<ButtonTheme>? other,
    double t,
  ) {
    if (other is! ButtonTheme) {
      return this;
    }

    return ButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      backgroundColor2:
          Color.lerp(backgroundColor2, other.backgroundColor2, t) ??
              backgroundColor2,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      textColor2: Color.lerp(textColor2, other.textColor2, t) ?? textColor2,
      textColor3: Color.lerp(textColor3, other.textColor3, t) ?? textColor3,
      textColor4: Color.lerp(textColor4, other.textColor4, t) ?? textColor4,
      // iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      // iconColor2: Color.lerp(iconColor2, other.iconColor2, t) ?? iconColor2,
      border: Border.lerp(border, other.border, t) ?? border,
      border2: Border.lerp(border2, other.border2, t) ?? border2,
      border3: Border.lerp(border3, other.border3, t) ?? border3,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
      borderRadius2: BorderRadius.lerp(borderRadius2, other.borderRadius2, t) ??
          borderRadius2,
    );
  }
}

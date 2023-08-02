import 'package:flutter/material.dart';

class NotificationTheme extends ThemeExtension<NotificationTheme> {
  final Color backgroundColor;
  final Color usernameColor;
  final Color textColor;
  final Color separatorColor;

  NotificationTheme({
    required this.backgroundColor,
    required this.usernameColor,
    required this.textColor,
    required this.separatorColor,
  });

  @override
  ThemeExtension<NotificationTheme> copyWith({
    Color? backgroundColor,
    Color? usernameColor,
    Color? textColor,
    Color? separatorColor,
  }) {
    return NotificationTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      usernameColor: usernameColor ?? this.usernameColor,
      textColor: textColor ?? this.textColor,
      separatorColor: separatorColor ?? this.separatorColor,
    );
  }

  @override
  ThemeExtension<NotificationTheme> lerp(
    covariant ThemeExtension<NotificationTheme>? other,
    double t,
  ) {
    if (other is! NotificationTheme) {
      return this;
    }

    return NotificationTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      usernameColor:
          Color.lerp(usernameColor, other.usernameColor, t) ?? usernameColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      separatorColor:
          Color.lerp(separatorColor, other.separatorColor, t) ?? separatorColor,
    );
  }
}

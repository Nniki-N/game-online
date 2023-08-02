import 'package:flutter/material.dart';

class SliderTheme extends ThemeExtension<SliderTheme> {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final Color activeTickMarkColor;
  final Color inactiveTickMarkColor;
  final Color sideBarColor;

  SliderTheme({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
    required this.activeTickMarkColor,
    required this.inactiveTickMarkColor,
    required this.sideBarColor,
  });

  @override
  ThemeExtension<SliderTheme> copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
    Color? activeTickMarkColor,
    Color? inactiveTickMarkColor,
    Color? sideBarColor,
  }) {
    return SliderTheme(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      activeTickMarkColor: activeTickMarkColor ?? this.activeTickMarkColor,
      inactiveTickMarkColor: inactiveTickMarkColor ?? this.inactiveTickMarkColor,
      sideBarColor: sideBarColor ?? this.sideBarColor,
    );
  }

  @override
  ThemeExtension<SliderTheme> lerp(
    covariant ThemeExtension<SliderTheme>? other,
    double t,
  ) {
    if (other is! SliderTheme) {
      return this;
    }

    return SliderTheme(
      activeTrackColor:
          Color.lerp(activeTrackColor, other.activeTrackColor, t) ??
              activeTrackColor,
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t) ??
              inactiveTrackColor,
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t) ?? thumbColor,
      activeTickMarkColor:
          Color.lerp(activeTickMarkColor, other.activeTickMarkColor, t) ??
              activeTickMarkColor,
      inactiveTickMarkColor:
          Color.lerp(inactiveTickMarkColor, other.inactiveTickMarkColor, t) ??
              inactiveTickMarkColor,
      sideBarColor:
          Color.lerp(sideBarColor, other.sideBarColor, t) ?? sideBarColor,
    );
  }
}

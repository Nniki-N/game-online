import 'package:flutter/material.dart';

class ConnectionsTabBarTheme extends ThemeExtension<ConnectionsTabBarTheme> {
  final Color backgroundColor;
  final Color selectedTabTextColor;
  final Color tabTextColor;
  final Color separatorColor;

  ConnectionsTabBarTheme({
    required this.backgroundColor,
    required this.selectedTabTextColor,
    required this.tabTextColor,
    required this.separatorColor,
  });

  @override
  ThemeExtension<ConnectionsTabBarTheme> copyWith({
    Color? backgroundColor,
    Color? selectedTabTextColor,
    Color? tabTextColor,
    Color? separatorColor,
  }) {
    return ConnectionsTabBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedTabTextColor: selectedTabTextColor ?? this.selectedTabTextColor,
      tabTextColor: tabTextColor ?? this.tabTextColor,
      separatorColor: separatorColor ?? this.separatorColor,
    );
  }

  @override
  ThemeExtension<ConnectionsTabBarTheme> lerp(
    covariant ThemeExtension<ConnectionsTabBarTheme>? other,
    double t,
  ) {
    if (other is! ConnectionsTabBarTheme) {
      return this;
    }

    return ConnectionsTabBarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      selectedTabTextColor:
          Color.lerp(selectedTabTextColor, other.selectedTabTextColor, t) ??
              selectedTabTextColor,
      tabTextColor:
          Color.lerp(tabTextColor, other.tabTextColor, t) ?? tabTextColor,
      separatorColor:
          Color.lerp(separatorColor, other.separatorColor, t) ?? separatorColor,
    );
  }
}

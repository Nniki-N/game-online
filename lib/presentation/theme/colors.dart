import 'package:flutter/material.dart';

abstract class CustomColors {
  // Colors.
  static Color get mainColor => const Color(0xff0B9933);
  static Color get darkGreenColor => const Color(0xff213A28);
  static Color get lightGreenColor => const Color(0xff599B6C);
  static Color get lightRedColor => const Color(0xffCE0E0E);
  static Color get darkRedColor => const Color(0xff900404);
  static Color get whiteColor => const Color(0xffffffff);
  static Color get blackColor => const Color(0xff000000);

  ///
  /// Light theme:
  ///

  // Background color.
  static Color get backgroundColor => whiteColor;
  static Color get backgroundColor2 => mainColor;

  // Bottom bar colors.
  static Color get bottomBarBackgroundColor => mainColor;
  static Color get bottomBarActiveColor => whiteColor;
  static Color get bottomBarInactiveColor => const Color(0xff80CA95);

  // Text Colors.
  static Color get textColor => blackColor;
  static Color get textColor2 => mainColor;
  static Color get textColor3 => const Color(0xff646464);
  static Color get textColor4 => lightRedColor;

  // FieldColors.
  static Color get fieldBackgroundColor => const Color(0xffEDEDED);
  static Color get fieldTextColor => blackColor;
  static Color get fieldHintextColor => const Color(0xff7C7C7C);
  static Color get fieldCursorColor => mainColor;

  // ButtonColors.
  static Color get buttonBackgroundColor => mainColor;
  static Color get buttonBackgroundColor2 => lightRedColor;
  static Color get buttonBorderColor => mainColor;
  static Color get buttonBorderColor2 => darkGreenColor;
  static Color get buttonBorderColor3 => darkRedColor;
  static Color get buttonTextColor => whiteColor;
  static Color get buttonTextColor2 => mainColor;
  static Color get buttonTextColor3 => darkGreenColor;
  static Color get buttonTextColor4 => darkRedColor;

  // Switch colors.
  static Color get activeSwitchBackgroundColor => lightGreenColor;
  static Color get activeSwitchForegroundColor => mainColor;
  static Color get inactiveSwitchBackgroundColor => Colors.grey.shade400;
  static Color get inactiveSwitchForegroundColor => Colors.grey.shade600;

  // Radio button colors.
  static Color get inactivRadioButtonColor => const Color(0xff5A5A5A);
  static Color get activRadioButtonColor => mainColor;

  // Slider colors.
  static Color get sliderActiveTrackColor => mainColor;
  static Color get sliderInactiveTrackColor => lightGreenColor;
  static Color get sliderThumbColor => mainColor;
  static Color get sliderActiveTickMarkColor => Colors.transparent;
  static Color get sliderInactiveTickMarkColor => Colors.transparent;
  static Color get sliderSideBarColor => mainColor;

  // Separator colors.
  static Color get signInSeparatorColor => lightGreenColor;
  static Color get connectionsTabSeparatorColor => darkGreenColor;
  static Color get popUpMenuSeparatorColor => const Color(0xffC5C5C5);
  static Color get notificationSeparatorColor => lightGreenColor;
  static Color get gameFieldSeparatorColor => const Color(0xff8FBD9C);

  // Game field colors.
  static Color get gameFieldBackgroundColor => const Color(0xffE0EDE4);

  // Connections tab bar colors.
  static Color get connectionsTabBarBackgroundColor => const Color(0xffEDEDED);
  static Color get connectionsTabBarTextColor => const Color(0xff7C7C7C);
  static Color get connectionsTabBarSelectedTextColor => mainColor;

  // Chips row colors.
  static Color get chipsRowBackgroundColor => const Color(0xffD7E8DC);
  static Color get chipsRowTextColor => textColor;

  // Settings item colors.
  static Color get settingsItemBackgroundColor => const Color(0xffEDEDED);
  static Color get settingsItemForegroundColor => blackColor;

  // Notification colors.
  static Color get notificationBackgroundColor => const Color(0xffE0EDE4);
  static Color get notificationUsernameColor => textColor;
  static Color get notificationTextColor => const Color(0xff464646);

  // Timer color.
  static Color get timerColor => darkGreenColor;

  // Popup menu colors.
  static Color get popUpMenuBackgroundColor => whiteColor;
  static Color get popUpMenuTextColor => textColor;
  static Color get popUpMenuShadowColor => blackColor.withOpacity(0.45);

  // Popup colors.
  static Color get popUpBackgroundColor => whiteColor;
  static Color get popUpTitleColor => textColor;
  static Color get popUpTextColor => textColor3;
  static Color get popUpOverlayColor => blackColor.withOpacity(0.6);

  // Icon colors.
  static Color get iconColor => blackColor;
  static Color get iconColor2 => mainColor;
  static Color get iconColor3 => darkGreenColor;
  static Color get iconColor4 => whiteColor;

  ///
  /// Dark theme:
  ///

  // Background color.
  static Color get darkBackgroundColor => const Color(0xff242424);
  static Color get darkBackgroundColor2 => mainColor;

  // Bottom bar colors.
  static Color get darkBottomBarBackgroundColor => mainColor;
  static Color get darkBottomBarActiveColor => whiteColor;
  static Color get darkBottomBarInactiveColor => const Color(0xff80CA95);

  // Text Colors.
  static Color get darkTextColor => whiteColor;
  static Color get darkTextColor2 => mainColor;
  static Color get darkTextColor3 => const Color(0xffA2A2A2);
  static Color get darkTextColor4 => lightRedColor;

  // FieldColors.
  static Color get darkFieldBackgroundColor => const Color(0xff3D3D3D);
  static Color get darkFieldTextColor => whiteColor;
  static Color get darkFieldHintextColor => const Color(0xffABABAB);
  static Color get darkFieldCursorColor => mainColor;

  // ButtonColors.
  static Color get darkButtonBackgroundColor => mainColor;
  static Color get darkButtonBackgroundColor2 => lightRedColor;
  static Color get darkButtonBorderColor => mainColor;
  static Color get darkButtonBorderColor2 => const Color(0xffD5E3D9);
  static Color get darkButtonBorderColor3 => const Color(0xffDC2727);
  static Color get darkButtonTextColor => whiteColor;
  static Color get darkButtonTextColor2 => mainColor;
  static Color get darkButtonTextColor3 => const Color(0xffD5E3D9);
  static Color get darkButtonTextColor4 => const Color(0xffDC2727);

  // Switch colors.
  static Color get darkActiveSwitchBackgroundColor => lightGreenColor;
  static Color get darkActiveSwitchForegroundColor => mainColor;
  static Color get darkInactiveSwitchBackgroundColor => Colors.grey.shade400;
  static Color get darkInactiveSwitchForegroundColor => Colors.grey.shade600;

  // Radio button colors.
  static Color get darkInactivRadioButtonColor => const Color(0xffA5A5A5);
  static Color get darkActivRadioButtonColor => mainColor;

  // Slider colors.
  static Color get darkSliderActiveTrackColor => mainColor;
  static Color get darkSliderInactiveTrackColor => const Color(0xff515151);
  static Color get darkSliderThumbColor => mainColor;
  static Color get darkSliderActiveTickMarkColor => Colors.transparent;
  static Color get darkSliderInactiveTickMarkColor => Colors.transparent;
  static Color get darkSliderSideBarColor => mainColor;

  // Separator colors.
  static Color get darkSignInSeparatorColor => const Color(0xff69716B);
  static Color get darkConnectionsTabSeparatorColor => const Color(0xff585858);
  static Color get darkPopUpMenuSeparatorColor => const Color(0xff4C4C4C);
  static Color get darkNotificationSeparatorColor => const Color(0xff525653);
  static Color get darkGameFieldSeparatorColor => darkBackgroundColor;

  // Game field colors.
  static Color get darkGameFieldBackgroundColor => const Color(0xff333C36);

  // Connections tab bar colors.
  static Color get darkConnectionsTabBarBackgroundColor =>
      const Color(0xff3D3D3D);
  static Color get darkConnectionsTabBarTextColor => const Color(0xffDADADA);
  static Color get darkConnectionsTabBarSelectedTextColor => mainColor;

  // Chips row colors.
  static Color get darkChipsRowBackgroundColor => const Color(0xff303030);
  static Color get darkChipsRowTextColor => darkTextColor;

  // Settings item colors.
  static Color get darkSettingsItemBackgroundColor => const Color(0xff3D3D3D);
  static Color get darkSettingsItemForegroundColor => whiteColor;

  // Notification colors.
  static Color get darkNotificationBackgroundColor => const Color(0xff303331);
  static Color get darkNotificationUsernameColor => darkTextColor;
  static Color get darkNotificationTextColor => const Color(0xffE7E7E7);

  // Timer color.
  static Color get darkTimerColor => const Color(0xffEDEDED);

  // Popup menu colors.
  static Color get darkPopUpMenuBackgroundColor => const Color(0xff383838);
  static Color get darkPopUpMenuTextColor => whiteColor;
  static Color get darkPopUpMenuShadowColor => blackColor.withOpacity(0.45);

  // Popup colors.
  static Color get darkPopUpBackgroundColor => const Color(0xff262626);
  static Color get darkPopUpTitleColor => darkTextColor;
  static Color get darkPopUpTextColor => darkTextColor3;
  static Color get darkPopUpOverlayColor => blackColor.withOpacity(0.65);

  // Icon colors.
  static Color get darkIconColor => whiteColor;
  static Color get darkIconColor2 => mainColor;
  static Color get darkIconColor3 => const Color(0xffB0C3B5);
  static Color get darkIconColor4 => whiteColor;
}

import 'package:flutter/material.dart'
    hide ButtonTheme, TextTheme, SwitchTheme, SliderTheme, IconTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/colors.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/bottom_bar_theme.dart';
import 'package:game/presentation/theme/extensions/button_theme.dart';
import 'package:game/presentation/theme/extensions/chips_row_theme.dart';
import 'package:game/presentation/theme/extensions/connections_tab_bar_theme.dart';
import 'package:game/presentation/theme/extensions/field_theme.dart';
import 'package:game/presentation/theme/extensions/game_field_theme.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/notification_theme.dart';
import 'package:game/presentation/theme/extensions/popup_menu_theme.dart';
import 'package:game/presentation/theme/extensions/popup_theme.dart';
import 'package:game/presentation/theme/extensions/radio_button_theme.dart';
import 'package:game/presentation/theme/extensions/settings_item_theme.dart';
import 'package:game/presentation/theme/extensions/slider_them.dart';
import 'package:game/presentation/theme/extensions/switch_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/theme/extensions/timer_theme.dart';

abstract class ThemeResources {
  // Background.
  static BackgroundTheme lightBackgroundTheme = BackgroundTheme(
    color: CustomColors.backgroundColor,
    color2: CustomColors.backgroundColor2,
  );
  static BackgroundTheme darkBackgroundTheme = BackgroundTheme(
    color: CustomColors.darkBackgroundColor,
    color2: CustomColors.darkBackgroundColor2,
  );

  // Bottom bar.
  static BottomBarTheme lightBottomBarTheme = BottomBarTheme(
    backgroundColor: CustomColors.bottomBarBackgroundColor,
    activeColor: CustomColors.bottomBarActiveColor,
    inactiveColor: CustomColors.bottomBarInactiveColor,
  );
  static BottomBarTheme darkBottomBarTheme = BottomBarTheme(
    backgroundColor: CustomColors.darkBottomBarBackgroundColor,
    activeColor: CustomColors.darkBottomBarActiveColor,
    inactiveColor: CustomColors.darkBottomBarInactiveColor,
  );

  // Button.
  static ButtonTheme lightButtonTheme = ButtonTheme(
    backgroundColor: CustomColors.buttonBackgroundColor,
    backgroundColor2: CustomColors.buttonBackgroundColor2,
    textColor: CustomColors.buttonTextColor,
    textColor2: CustomColors.buttonTextColor2,
    textColor3: CustomColors.buttonTextColor3,
    textColor4: CustomColors.buttonTextColor4,
    border: Border.all(
      color: CustomColors.buttonBorderColor,
      width: 2.w,
    ),
    border2: Border.all(
      color: CustomColors.buttonBorderColor2,
      width: 2.w,
    ),
    border3: Border.all(
      color: CustomColors.buttonBorderColor3,
      width: 2.w,
    ),
    borderRadius: BorderRadius.circular(10.h),
    borderRadius2: BorderRadius.circular(8.h),
  );
  static ButtonTheme darkButtonTheme = ButtonTheme(
    backgroundColor: CustomColors.darkButtonBackgroundColor,
    backgroundColor2: CustomColors.darkButtonBackgroundColor2,
    textColor: CustomColors.darkButtonTextColor,
    textColor2: CustomColors.darkButtonTextColor2,
    textColor3: CustomColors.darkButtonTextColor3,
    textColor4: CustomColors.darkButtonTextColor4,
    border: Border.all(
      color: CustomColors.darkButtonBorderColor,
      width: 2.w,
    ),
    border2: Border.all(
      color: CustomColors.darkButtonBorderColor2,
      width: 2.w,
    ),
    border3: Border.all(
      color: CustomColors.darkButtonBorderColor3,
      width: 2.w,
    ),
    borderRadius: BorderRadius.circular(10.h),
    borderRadius2: BorderRadius.circular(8.h),
  );

  // Text.
  static TextTheme lightTextTheme = TextTheme(
    color: CustomColors.textColor,
    color2: CustomColors.textColor2,
    color3: CustomColors.textColor3,
    color4: CustomColors.textColor4,
  );
  static TextTheme darkTextTheme = TextTheme(
    color: CustomColors.darkTextColor,
    color2: CustomColors.darkTextColor2,
    color3: CustomColors.darkTextColor3,
    color4: CustomColors.darkTextColor4,
  );

  // Field.
  static FieldTheme lightFieldTheme = FieldTheme(
    backgroundColor: CustomColors.fieldBackgroundColor,
    textColor: CustomColors.fieldTextColor,
    hintextColor: CustomColors.fieldHintextColor,
    cursorColor: CustomColors.fieldCursorColor,
    borderRadius: BorderRadius.circular(10.w),
  );
  static FieldTheme darkFieldTheme = FieldTheme(
    backgroundColor: CustomColors.darkFieldBackgroundColor,
    textColor: CustomColors.darkFieldTextColor,
    hintextColor: CustomColors.darkFieldHintextColor,
    cursorColor: CustomColors.darkFieldCursorColor,
    borderRadius: BorderRadius.circular(10.w),
  );

  // Switch.
  static SwitchTheme lightSwitchTheme = SwitchTheme(
    activeBackgroundColor: CustomColors.activeSwitchBackgroundColor,
    activeForegroundColor: CustomColors.activeSwitchForegroundColor,
    inactiveBackgroundColor: CustomColors.inactiveSwitchBackgroundColor,
    inactiveForegroundColor: CustomColors.inactiveSwitchForegroundColor,
  );
  static SwitchTheme darkSwitchTheme = SwitchTheme(
    activeBackgroundColor: CustomColors.darkActiveSwitchBackgroundColor,
    activeForegroundColor: CustomColors.darkActiveSwitchForegroundColor,
    inactiveBackgroundColor: CustomColors.darkInactiveSwitchBackgroundColor,
    inactiveForegroundColor: CustomColors.darkInactiveSwitchForegroundColor,
  );

  // Radio button.
  static RadioButtonTheme lightRadioButtonTheme = RadioButtonTheme(
    inactivColor: CustomColors.inactivRadioButtonColor,
    activColor: CustomColors.activRadioButtonColor,
  );
  static RadioButtonTheme darkRadioButtonTheme = RadioButtonTheme(
    inactivColor: CustomColors.darkInactivRadioButtonColor,
    activColor: CustomColors.darkActivRadioButtonColor,
  );

  // Slider.
  static SliderTheme lightSliderTheme = SliderTheme(
    activeTrackColor: CustomColors.sliderActiveTrackColor,
    inactiveTrackColor: CustomColors.sliderInactiveTrackColor,
    thumbColor: CustomColors.sliderThumbColor,
    activeTickMarkColor: CustomColors.sliderActiveTickMarkColor,
    inactiveTickMarkColor: CustomColors.sliderInactiveTickMarkColor,
    sideBarColor: CustomColors.sliderSideBarColor,
  );
  static SliderTheme darkSliderTheme = SliderTheme(
    activeTrackColor: CustomColors.darkSliderActiveTrackColor,
    inactiveTrackColor: CustomColors.darkSliderInactiveTrackColor,
    thumbColor: CustomColors.darkSliderThumbColor,
    activeTickMarkColor: CustomColors.darkSliderActiveTickMarkColor,
    inactiveTickMarkColor: CustomColors.darkSliderInactiveTickMarkColor,
    sideBarColor: CustomColors.darkSliderSideBarColor,
  );

  // Timer.
  static TimerTheme lightTimerTheme = TimerTheme(
    color: CustomColors.timerColor,
  );
  static TimerTheme darkTimerTheme = TimerTheme(
    color: CustomColors.darkTimerColor,
  );

  // Notification.
  static NotificationTheme lightNotificationTheme = NotificationTheme(
    backgroundColor: CustomColors.notificationBackgroundColor,
    usernameColor: CustomColors.notificationUsernameColor,
    textColor: CustomColors.notificationTextColor,
    separatorColor: CustomColors.notificationSeparatorColor,
  );
  static NotificationTheme darkNotificationTheme = NotificationTheme(
    backgroundColor: CustomColors.darkNotificationBackgroundColor,
    usernameColor: CustomColors.darkNotificationUsernameColor,
    textColor: CustomColors.darkNotificationTextColor,
    separatorColor: CustomColors.darkNotificationSeparatorColor,
  );

  // Connections tab bar.
  static ConnectionsTabBarTheme lightConnectionsTabBarTheme =
      ConnectionsTabBarTheme(
    backgroundColor: CustomColors.connectionsTabBarBackgroundColor,
    selectedTabTextColor: CustomColors.connectionsTabBarSelectedTextColor,
    tabTextColor: CustomColors.connectionsTabBarTextColor,
    separatorColor: CustomColors.connectionsTabSeparatorColor,
  );
  static ConnectionsTabBarTheme darkConnectionsTabBarTheme =
      ConnectionsTabBarTheme(
    backgroundColor: CustomColors.darkConnectionsTabBarBackgroundColor,
    selectedTabTextColor: CustomColors.darkConnectionsTabBarSelectedTextColor,
    tabTextColor: CustomColors.darkConnectionsTabBarTextColor,
    separatorColor: CustomColors.darkConnectionsTabSeparatorColor,
  );

  // Connections tab bar.
  static ChipsRowTheme lightChipsRowTheme = ChipsRowTheme(
    backgroundColor: CustomColors.chipsRowBackgroundColor,
    textColor: CustomColors.chipsRowTextColor,
  );
  static ChipsRowTheme darkChipsRowTheme = ChipsRowTheme(
    backgroundColor: CustomColors.darkChipsRowBackgroundColor,
    textColor: CustomColors.darkChipsRowTextColor,
  );

  // Popup menu.
  static PopUpMenuTheme lightPopUpMenuTheme = PopUpMenuTheme(
    backgroundColor: CustomColors.popUpMenuBackgroundColor,
    textColor: CustomColors.popUpMenuTextColor,
    separatorColor: CustomColors.popUpMenuSeparatorColor,
    shadowColor: CustomColors.popUpMenuShadowColor,
    borderRadius: BorderRadius.circular(8.w),
  );
  static PopUpMenuTheme darkPopUpMenuTheme = PopUpMenuTheme(
    backgroundColor: CustomColors.darkPopUpMenuBackgroundColor,
    textColor: CustomColors.darkTextColor,
    separatorColor: CustomColors.darkPopUpMenuSeparatorColor,
    shadowColor: CustomColors.darkPopUpMenuShadowColor,
    borderRadius: BorderRadius.circular(8.w),
  );

  // Popup.
  static PopUpTheme lightPopUpTheme = PopUpTheme(
    backgroundColor: CustomColors.popUpBackgroundColor,
    textColor: CustomColors.popUpTextColor,
    titleColor: CustomColors.popUpTitleColor,
    overlayColor: CustomColors.popUpOverlayColor,
    borderRadius: BorderRadius.circular(8.w),
  );
  static PopUpTheme darkPopUpTheme = PopUpTheme(
    backgroundColor: CustomColors.darkPopUpBackgroundColor,
    textColor: CustomColors.darkPopUpTextColor,
    titleColor: CustomColors.darkPopUpTitleColor,
    overlayColor: CustomColors.darkPopUpOverlayColor,
    borderRadius: BorderRadius.circular(8.w),
  );

  // Game field.
  static GameFieldTheme lightGameFieldTheme = GameFieldTheme(
    backgroundColor: CustomColors.gameFieldBackgroundColor,
    separatorColor: CustomColors.gameFieldSeparatorColor,
    borderRadius: BorderRadius.circular(20.w),
  );
  static GameFieldTheme darkGameFieldTheme = GameFieldTheme(
    backgroundColor: CustomColors.darkGameFieldBackgroundColor,
    separatorColor: CustomColors.darkGameFieldSeparatorColor,
    borderRadius: BorderRadius.circular(20.w),
  );

  // Icon.
  static IconTheme lightIconTheme = IconTheme(
    color: CustomColors.iconColor,
    color2: CustomColors.iconColor2,
    color3: CustomColors.iconColor3,
    color4: CustomColors.iconColor4,
  );
  static IconTheme darkIconTheme = IconTheme(
    color: CustomColors.darkIconColor,
    color2: CustomColors.darkIconColor2,
    color3: CustomColors.darkIconColor3,
    color4: CustomColors.darkIconColor4,
  );

  // Settings Item.
  static SettingsItemTheme lightSettingsItemTheme = SettingsItemTheme(
    backgroundColor: CustomColors.settingsItemBackgroundColor,
    foregroundColor: CustomColors.settingsItemForegroundColor,
  );
  static SettingsItemTheme darkSettingsItemTheme = SettingsItemTheme(
    backgroundColor: CustomColors.darkSettingsItemBackgroundColor,
    foregroundColor: CustomColors.darkSettingsItemForegroundColor,
  );
}

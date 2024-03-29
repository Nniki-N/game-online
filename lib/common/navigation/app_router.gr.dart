// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i23;

import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;

import '../../presentation/screens/add_friend_screen/add_friend_screen.dart'
    deferred as _i12;
import '../../presentation/screens/auth_screens/registration_screen.dart'
    deferred as _i3;
import '../../presentation/screens/auth_screens/signin_screen.dart'
    deferred as _i2;
import '../../presentation/screens/choose_friend_for_game_screen/choose_friend_for_game_screen.dart'
    deferred as _i13;
import '../../presentation/screens/game_rules_screen/game_rules_screen.dart'
    deferred as _i11;
import '../../presentation/screens/game_screens/online_game_screen/online_game_screen.dart'
    deferred as _i10;
import '../../presentation/screens/game_screens/waiting_room_screen/waiting_room_screen.dart'
    deferred as _i9;
import '../../presentation/screens/initial_screen/initial_screen.dart'
    deferred as _i1;
import '../../presentation/screens/loading_screen.dart/loading_screen.dart'
    deferred as _i15;
import '../../presentation/screens/main_screen/connections_page/connection_page.dart'
    deferred as _i16;
import '../../presentation/screens/main_screen/connections_page/friends_tab/friends_tab.dart'
    deferred as _i19;
import '../../presentation/screens/main_screen/connections_page/notifications_tab/notifications_tab.dart'
    deferred as _i20;
import '../../presentation/screens/main_screen/home_page/home_page.dart'
    deferred as _i17;
import '../../presentation/screens/main_screen/main_screen.dart'
    deferred as _i4;
import '../../presentation/screens/main_screen/settings_page/settings_page.dart'
    deferred as _i18;
import '../../presentation/screens/not_existing_screen/not_existing_screen.dart'
    deferred as _i14;
import '../../presentation/screens/settings_screens/appearance_settings_screen/appearance_settings_screen.dart'
    deferred as _i6;
import '../../presentation/screens/settings_screens/language_settings_screen/language_settings_screen.dart'
    deferred as _i7;
import '../../presentation/screens/settings_screens/profile_settings_screen/profile_settings_screen.dart'
    deferred as _i5;
import '../../presentation/screens/settings_screens/settings_register_screen/settings_register_screen.dart'
    deferred as _i8;

class AppRouter extends _i21.RootStackRouter {
  AppRouter([_i22.GlobalKey<_i22.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    InitialRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.InitialScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.SignInScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.RegistrationScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.MainScreen(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSettingsRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.ProfileSettingsScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppearanceSettingsRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.AppearanceSettingsScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LanguageSettingsRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.LanguageSettingsScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingsRegisterRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.SettingsRegisterScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    WaitingRoomRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.WaitingRoomScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnlineGameRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.OnlineGameScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GameRulesRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.GameRulesScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AddFriendRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.AddFriendScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChoosefriendForGameRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.ChoosefriendForGameScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotExistingRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.NotExistingScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRouter.name: (routeData) {
      final args = routeData.argsAs<LoadingRouterArgs>(
          orElse: () => const LoadingRouterArgs());
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i15.loadLibrary,
          () => _i15.LoadingScreen(
            key: args.key,
            backgroundColor: args.backgroundColor,
            animationWidgetColor: args.animationWidgetColor,
            loadingTitle: args.loadingTitle,
            loadingText: args.loadingText,
          ),
        ),
        maintainState: false,
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ConnectionsRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i16.loadLibrary,
          () => _i16.ConnectionPage(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i17.loadLibrary,
          () => _i17.HomePage(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingsRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i18.loadLibrary,
          () => _i18.SettingsPage(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FriendsTabRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i19.loadLibrary,
          () => _i19.FriendsTab(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationsTabRouter.name: (routeData) {
      return _i21.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.DeferredWidget(
          _i20.loadLibrary,
          () => _i20.NotificationsTab(),
        ),
        transitionsBuilder: _i21.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        reverseDurationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i21.RouteConfig> get routes => [
        _i21.RouteConfig(
          InitialRouter.name,
          path: '/',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          SignInRouter.name,
          path: '/signin',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          RegistrationRouter.name,
          path: '/registration',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          MainRouter.name,
          path: '/main',
          deferredLoading: true,
          children: [
            _i21.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRouter.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i21.RouteConfig(
              ConnectionsRouter.name,
              path: 'connections',
              parent: MainRouter.name,
              deferredLoading: true,
              children: [
                _i21.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ConnectionsRouter.name,
                  redirectTo: 'friends',
                  fullMatch: true,
                ),
                _i21.RouteConfig(
                  FriendsTabRouter.name,
                  path: 'friends',
                  parent: ConnectionsRouter.name,
                  deferredLoading: true,
                ),
                _i21.RouteConfig(
                  NotificationsTabRouter.name,
                  path: 'notifications',
                  parent: ConnectionsRouter.name,
                  deferredLoading: true,
                ),
              ],
            ),
            _i21.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: MainRouter.name,
              deferredLoading: true,
            ),
            _i21.RouteConfig(
              SettingsRouter.name,
              path: 'settings',
              parent: MainRouter.name,
              deferredLoading: true,
            ),
          ],
        ),
        _i21.RouteConfig(
          ProfileSettingsRouter.name,
          path: '/profileSettings',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          AppearanceSettingsRouter.name,
          path: '/appearanceSettings',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          LanguageSettingsRouter.name,
          path: '/languageSettings',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          SettingsRegisterRouter.name,
          path: '/settingsRegister',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          WaitingRoomRouter.name,
          path: '/waitingRoom',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          OnlineGameRouter.name,
          path: '/onlineGame',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          GameRulesRouter.name,
          path: '/gameRules',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          AddFriendRouter.name,
          path: '/addFiend',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          ChoosefriendForGameRouter.name,
          path: '/choosefriendForGame',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          NotExistingRouter.name,
          path: '/notExisting',
          deferredLoading: true,
        ),
        _i21.RouteConfig(
          LoadingRouter.name,
          path: '/loading',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.InitialScreen]
class InitialRouter extends _i21.PageRouteInfo<void> {
  const InitialRouter()
      : super(
          InitialRouter.name,
          path: '/',
        );

  static const String name = 'InitialRouter';
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRouter extends _i21.PageRouteInfo<void> {
  const SignInRouter()
      : super(
          SignInRouter.name,
          path: '/signin',
        );

  static const String name = 'SignInRouter';
}

/// generated route for
/// [_i3.RegistrationScreen]
class RegistrationRouter extends _i21.PageRouteInfo<void> {
  const RegistrationRouter()
      : super(
          RegistrationRouter.name,
          path: '/registration',
        );

  static const String name = 'RegistrationRouter';
}

/// generated route for
/// [_i4.MainScreen]
class MainRouter extends _i21.PageRouteInfo<void> {
  const MainRouter({List<_i21.PageRouteInfo>? children})
      : super(
          MainRouter.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRouter';
}

/// generated route for
/// [_i5.ProfileSettingsScreen]
class ProfileSettingsRouter extends _i21.PageRouteInfo<void> {
  const ProfileSettingsRouter()
      : super(
          ProfileSettingsRouter.name,
          path: '/profileSettings',
        );

  static const String name = 'ProfileSettingsRouter';
}

/// generated route for
/// [_i6.AppearanceSettingsScreen]
class AppearanceSettingsRouter extends _i21.PageRouteInfo<void> {
  const AppearanceSettingsRouter()
      : super(
          AppearanceSettingsRouter.name,
          path: '/appearanceSettings',
        );

  static const String name = 'AppearanceSettingsRouter';
}

/// generated route for
/// [_i7.LanguageSettingsScreen]
class LanguageSettingsRouter extends _i21.PageRouteInfo<void> {
  const LanguageSettingsRouter()
      : super(
          LanguageSettingsRouter.name,
          path: '/languageSettings',
        );

  static const String name = 'LanguageSettingsRouter';
}

/// generated route for
/// [_i8.SettingsRegisterScreen]
class SettingsRegisterRouter extends _i21.PageRouteInfo<void> {
  const SettingsRegisterRouter()
      : super(
          SettingsRegisterRouter.name,
          path: '/settingsRegister',
        );

  static const String name = 'SettingsRegisterRouter';
}

/// generated route for
/// [_i9.WaitingRoomScreen]
class WaitingRoomRouter extends _i21.PageRouteInfo<void> {
  const WaitingRoomRouter()
      : super(
          WaitingRoomRouter.name,
          path: '/waitingRoom',
        );

  static const String name = 'WaitingRoomRouter';
}

/// generated route for
/// [_i10.OnlineGameScreen]
class OnlineGameRouter extends _i21.PageRouteInfo<void> {
  const OnlineGameRouter()
      : super(
          OnlineGameRouter.name,
          path: '/onlineGame',
        );

  static const String name = 'OnlineGameRouter';
}

/// generated route for
/// [_i11.GameRulesScreen]
class GameRulesRouter extends _i21.PageRouteInfo<void> {
  const GameRulesRouter()
      : super(
          GameRulesRouter.name,
          path: '/gameRules',
        );

  static const String name = 'GameRulesRouter';
}

/// generated route for
/// [_i12.AddFriendScreen]
class AddFriendRouter extends _i21.PageRouteInfo<void> {
  const AddFriendRouter()
      : super(
          AddFriendRouter.name,
          path: '/addFiend',
        );

  static const String name = 'AddFriendRouter';
}

/// generated route for
/// [_i13.ChoosefriendForGameScreen]
class ChoosefriendForGameRouter extends _i21.PageRouteInfo<void> {
  const ChoosefriendForGameRouter()
      : super(
          ChoosefriendForGameRouter.name,
          path: '/choosefriendForGame',
        );

  static const String name = 'ChoosefriendForGameRouter';
}

/// generated route for
/// [_i14.NotExistingScreen]
class NotExistingRouter extends _i21.PageRouteInfo<void> {
  const NotExistingRouter()
      : super(
          NotExistingRouter.name,
          path: '/notExisting',
        );

  static const String name = 'NotExistingRouter';
}

/// generated route for
/// [_i15.LoadingScreen]
class LoadingRouter extends _i21.PageRouteInfo<LoadingRouterArgs> {
  LoadingRouter({
    _i22.Key? key,
    _i23.Color? backgroundColor,
    _i23.Color? animationWidgetColor,
    String? loadingTitle,
    String? loadingText,
  }) : super(
          LoadingRouter.name,
          path: '/loading',
          args: LoadingRouterArgs(
            key: key,
            backgroundColor: backgroundColor,
            animationWidgetColor: animationWidgetColor,
            loadingTitle: loadingTitle,
            loadingText: loadingText,
          ),
        );

  static const String name = 'LoadingRouter';
}

class LoadingRouterArgs {
  const LoadingRouterArgs({
    this.key,
    this.backgroundColor,
    this.animationWidgetColor,
    this.loadingTitle,
    this.loadingText,
  });

  final _i22.Key? key;

  final _i23.Color? backgroundColor;

  final _i23.Color? animationWidgetColor;

  final String? loadingTitle;

  final String? loadingText;

  @override
  String toString() {
    return 'LoadingRouterArgs{key: $key, backgroundColor: $backgroundColor, animationWidgetColor: $animationWidgetColor, loadingTitle: $loadingTitle, loadingText: $loadingText}';
  }
}

/// generated route for
/// [_i16.ConnectionPage]
class ConnectionsRouter extends _i21.PageRouteInfo<void> {
  const ConnectionsRouter({List<_i21.PageRouteInfo>? children})
      : super(
          ConnectionsRouter.name,
          path: 'connections',
          initialChildren: children,
        );

  static const String name = 'ConnectionsRouter';
}

/// generated route for
/// [_i17.HomePage]
class HomeRouter extends _i21.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: 'home',
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i18.SettingsPage]
class SettingsRouter extends _i21.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i19.FriendsTab]
class FriendsTabRouter extends _i21.PageRouteInfo<void> {
  const FriendsTabRouter()
      : super(
          FriendsTabRouter.name,
          path: 'friends',
        );

  static const String name = 'FriendsTabRouter';
}

/// generated route for
/// [_i20.NotificationsTab]
class NotificationsTabRouter extends _i21.PageRouteInfo<void> {
  const NotificationsTabRouter()
      : super(
          NotificationsTabRouter.name,
          path: 'notifications',
        );

  static const String name = 'NotificationsTabRouter';
}

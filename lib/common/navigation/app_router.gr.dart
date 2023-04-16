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
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../../presentation/screens/auth_screens/login_screen.dart'
    deferred as _i2;
import '../../presentation/screens/auth_screens/registration_screen.dart'
    deferred as _i3;
import '../../presentation/screens/game_screens/offline_game_screen/offline_game_screen.dart'
    deferred as _i9;
import '../../presentation/screens/game_screens/online_game_screen/online_game_screen.dart'
    deferred as _i10;
import '../../presentation/screens/game_screens/waiting_room_screen/waiting_room_screen.dart'
    deferred as _i8;
import '../../presentation/screens/initial_screen/initial_screen.dart'
    deferred as _i1;
import '../../presentation/screens/loading_screen.dart/loading_screen.dart'
    deferred as _i12;
import '../../presentation/screens/main_screen/connections_page/connection_page.dart'
    deferred as _i13;
import '../../presentation/screens/main_screen/connections_page/friends_tab/friends_tab.dart'
    deferred as _i16;
import '../../presentation/screens/main_screen/connections_page/notifications_tab/notifications_tab.dart'
    deferred as _i17;
import '../../presentation/screens/main_screen/home_page/home_page.dart'
    deferred as _i14;
import '../../presentation/screens/main_screen/main_screen.dart'
    deferred as _i4;
import '../../presentation/screens/main_screen/settings_page/settings_page.dart'
    deferred as _i15;
import '../../presentation/screens/not_existing_screen/not_existing_screen.dart'
    deferred as _i11;
import '../../presentation/screens/settings_screens/appearance_settings_screen/appearance_settings_screen.dart'
    deferred as _i6;
import '../../presentation/screens/settings_screens/language_settings_screen/language_settings_screen.dart'
    deferred as _i7;
import '../../presentation/screens/settings_screens/profile_settings_screen/profile_settings_screen.dart'
    deferred as _i5;

class AppRouter extends _i18.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    InitialRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.InitialScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.LogInScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.RegistrationScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.MainScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSettingsRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.ProfileSettingsScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppearanceSettingsRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.AppearanceSettingsAcreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LanguageSettingsRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.LanguageSettingsScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    WaitingRoomRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.WaitingRoomScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OfflineGameRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.OfflineGameScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnlineGameRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.OnlineGameScreen(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotExistingRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.NotExistingScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.LoadingScreen(),
        ),
        maintainState: false,
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ConnectionsRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.ConnectionPage(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.HomePage(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingsRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i15.loadLibrary,
          () => _i15.SettingsPage(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FriendsTabRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i16.loadLibrary,
          () => _i16.FriendsTab(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationsTabRouter.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i17.loadLibrary,
          () => _i17.NotificationsTab(),
        ),
        transitionsBuilder: _i18.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(
          InitialRouter.name,
          path: '/',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          LoginRouter.name,
          path: '/login',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          RegistrationRouter.name,
          path: '/registration',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          MainRouter.name,
          path: '/main',
          deferredLoading: true,
          children: [
            _i18.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRouter.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i18.RouteConfig(
              ConnectionsRouter.name,
              path: 'connections',
              parent: MainRouter.name,
              deferredLoading: true,
              children: [
                _i18.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ConnectionsRouter.name,
                  redirectTo: 'friends',
                  fullMatch: true,
                ),
                _i18.RouteConfig(
                  FriendsTabRouter.name,
                  path: 'friends',
                  parent: ConnectionsRouter.name,
                  deferredLoading: true,
                ),
                _i18.RouteConfig(
                  NotificationsTabRouter.name,
                  path: 'notifications',
                  parent: ConnectionsRouter.name,
                  deferredLoading: true,
                ),
              ],
            ),
            _i18.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: MainRouter.name,
              deferredLoading: true,
            ),
            _i18.RouteConfig(
              SettingsRouter.name,
              path: 'settings',
              parent: MainRouter.name,
              deferredLoading: true,
            ),
          ],
        ),
        _i18.RouteConfig(
          ProfileSettingsRouter.name,
          path: 'profileSettings',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          AppearanceSettingsRouter.name,
          path: 'appearanceSettings',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          LanguageSettingsRouter.name,
          path: 'languageSettings',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          WaitingRoomRouter.name,
          path: '/waitingRoom',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          OfflineGameRouter.name,
          path: '/offlineGame',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          OnlineGameRouter.name,
          path: '/onlineGame',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          NotExistingRouter.name,
          path: '/notExisting',
          deferredLoading: true,
        ),
        _i18.RouteConfig(
          LoadingRouter.name,
          path: '/loading',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.InitialScreen]
class InitialRouter extends _i18.PageRouteInfo<void> {
  const InitialRouter()
      : super(
          InitialRouter.name,
          path: '/',
        );

  static const String name = 'InitialRouter';
}

/// generated route for
/// [_i2.LogInScreen]
class LoginRouter extends _i18.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: '/login',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.RegistrationScreen]
class RegistrationRouter extends _i18.PageRouteInfo<void> {
  const RegistrationRouter()
      : super(
          RegistrationRouter.name,
          path: '/registration',
        );

  static const String name = 'RegistrationRouter';
}

/// generated route for
/// [_i4.MainScreen]
class MainRouter extends _i18.PageRouteInfo<void> {
  const MainRouter({List<_i18.PageRouteInfo>? children})
      : super(
          MainRouter.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRouter';
}

/// generated route for
/// [_i5.ProfileSettingsScreen]
class ProfileSettingsRouter extends _i18.PageRouteInfo<void> {
  const ProfileSettingsRouter()
      : super(
          ProfileSettingsRouter.name,
          path: 'profileSettings',
        );

  static const String name = 'ProfileSettingsRouter';
}

/// generated route for
/// [_i6.AppearanceSettingsAcreen]
class AppearanceSettingsRouter extends _i18.PageRouteInfo<void> {
  const AppearanceSettingsRouter()
      : super(
          AppearanceSettingsRouter.name,
          path: 'appearanceSettings',
        );

  static const String name = 'AppearanceSettingsRouter';
}

/// generated route for
/// [_i7.LanguageSettingsScreen]
class LanguageSettingsRouter extends _i18.PageRouteInfo<void> {
  const LanguageSettingsRouter()
      : super(
          LanguageSettingsRouter.name,
          path: 'languageSettings',
        );

  static const String name = 'LanguageSettingsRouter';
}

/// generated route for
/// [_i8.WaitingRoomScreen]
class WaitingRoomRouter extends _i18.PageRouteInfo<void> {
  const WaitingRoomRouter()
      : super(
          WaitingRoomRouter.name,
          path: '/waitingRoom',
        );

  static const String name = 'WaitingRoomRouter';
}

/// generated route for
/// [_i9.OfflineGameScreen]
class OfflineGameRouter extends _i18.PageRouteInfo<void> {
  const OfflineGameRouter()
      : super(
          OfflineGameRouter.name,
          path: '/offlineGame',
        );

  static const String name = 'OfflineGameRouter';
}

/// generated route for
/// [_i10.OnlineGameScreen]
class OnlineGameRouter extends _i18.PageRouteInfo<void> {
  const OnlineGameRouter()
      : super(
          OnlineGameRouter.name,
          path: '/onlineGame',
        );

  static const String name = 'OnlineGameRouter';
}

/// generated route for
/// [_i11.NotExistingScreen]
class NotExistingRouter extends _i18.PageRouteInfo<void> {
  const NotExistingRouter()
      : super(
          NotExistingRouter.name,
          path: '/notExisting',
        );

  static const String name = 'NotExistingRouter';
}

/// generated route for
/// [_i12.LoadingScreen]
class LoadingRouter extends _i18.PageRouteInfo<void> {
  const LoadingRouter()
      : super(
          LoadingRouter.name,
          path: '/loading',
        );

  static const String name = 'LoadingRouter';
}

/// generated route for
/// [_i13.ConnectionPage]
class ConnectionsRouter extends _i18.PageRouteInfo<void> {
  const ConnectionsRouter({List<_i18.PageRouteInfo>? children})
      : super(
          ConnectionsRouter.name,
          path: 'connections',
          initialChildren: children,
        );

  static const String name = 'ConnectionsRouter';
}

/// generated route for
/// [_i14.HomePage]
class HomeRouter extends _i18.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: 'home',
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i15.SettingsPage]
class SettingsRouter extends _i18.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i16.FriendsTab]
class FriendsTabRouter extends _i18.PageRouteInfo<void> {
  const FriendsTabRouter()
      : super(
          FriendsTabRouter.name,
          path: 'friends',
        );

  static const String name = 'FriendsTabRouter';
}

/// generated route for
/// [_i17.NotificationsTab]
class NotificationsTabRouter extends _i18.PageRouteInfo<void> {
  const NotificationsTabRouter()
      : super(
          NotificationsTabRouter.name,
          path: 'notifications',
        );

  static const String name = 'NotificationsTabRouter';
}

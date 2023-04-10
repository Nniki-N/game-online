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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../presentation/screens/auth_screens/login_screen.dart'
    deferred as _i2;
import '../../presentation/screens/auth_screens/registration_screen.dart'
    deferred as _i3;
import '../../presentation/screens/initial_screen/initial_screen.dart'
    deferred as _i1;
import '../../presentation/screens/main_screen/main_screen.dart'
    deferred as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    InitialRouter.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.InitialScreen(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRouter.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.LogInScreen(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegistrationRouter.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.RegistrationScreen(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRouter.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.MainScreen(),
        ),
        transitionsBuilder: _i5.TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          InitialRouter.name,
          path: '/',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          LoginRouter.name,
          path: '/login',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          RegistrationRouter.name,
          path: '/registration',
          deferredLoading: true,
        ),
        _i5.RouteConfig(
          MainRouter.name,
          path: '/main',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.InitialScreen]
class InitialRouter extends _i5.PageRouteInfo<void> {
  const InitialRouter()
      : super(
          InitialRouter.name,
          path: '/',
        );

  static const String name = 'InitialRouter';
}

/// generated route for
/// [_i2.LogInScreen]
class LoginRouter extends _i5.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: '/login',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.RegistrationScreen]
class RegistrationRouter extends _i5.PageRouteInfo<void> {
  const RegistrationRouter()
      : super(
          RegistrationRouter.name,
          path: '/registration',
        );

  static const String name = 'RegistrationRouter';
}

/// generated route for
/// [_i4.MainScreen]
class MainRouter extends _i5.PageRouteInfo<void> {
  const MainRouter()
      : super(
          MainRouter.name,
          path: '/main',
        );

  static const String name = 'MainRouter';
}

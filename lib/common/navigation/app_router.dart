
import 'package:auto_route/auto_route.dart';
import 'package:game/presentation/screens/auth_screens/login_screen.dart';
import 'package:game/presentation/screens/auth_screens/registration_screen.dart';
import 'package:game/presentation/screens/initial_screen/initial_screen.dart';
import 'package:game/presentation/screens/main_screen/main_screen.dart';

@CustomAutoRouter(
  durationInMilliseconds: 0,
  reverseDurationInMilliseconds: 0,
  deferredLoading: true,
  transitionsBuilder: TransitionsBuilders.noTransition,
  // replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: InitialScreen,
      name: 'InitialRouter',
      initial: true,
    ),
    AutoRoute(
      path: '/login',
      page: LogInScreen,
      name: 'LoginRouter',
    ),
    AutoRoute(
      path: '/registration',
      page: RegistrationScreen,
      name: 'RegistrationRouter',
    ),
    AutoRoute(
      path: '/main',
      page: MainScreen,
      name: 'MainRouter',
    ),
  ],
)
class $AppRouter {}
import 'package:auto_route/auto_route.dart';
import 'package:game/presentation/screens/auth_screens/login_screen.dart';
import 'package:game/presentation/screens/auth_screens/registration_screen.dart';
import 'package:game/presentation/screens/game_screens/offline_game_screen/offline_game_screen.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/online_game_screen.dart';
import 'package:game/presentation/screens/game_screens/waiting_room_screen/waiting_room_screen.dart';
import 'package:game/presentation/screens/initial_screen/initial_screen.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/screens/main_screen/connections_page/connection_page.dart';
import 'package:game/presentation/screens/main_screen/connections_page/friends_tab/friends_tab.dart';
import 'package:game/presentation/screens/main_screen/connections_page/notifications_tab/notifications_tab.dart';
import 'package:game/presentation/screens/main_screen/home_page/home_page.dart';
import 'package:game/presentation/screens/main_screen/main_screen.dart';
import 'package:game/presentation/screens/main_screen/settings_page/settings_page.dart';
import 'package:game/presentation/screens/not_existing_screen/not_existing_screen.dart';
import 'package:game/presentation/screens/settings_screens/appearance_settings_screen/appearance_settings_screen.dart';
import 'package:game/presentation/screens/settings_screens/language_settings_screen/language_settings_screen.dart';
import 'package:game/presentation/screens/settings_screens/profile_settings_screen/profile_settings_screen.dart';

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
      maintainState: false,
      initial: true,
    ),
    AutoRoute(
      path: '/login',
      page: LogInScreen,
      name: 'LoginRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/registration',
      page: RegistrationScreen,
      name: 'RegistrationRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/main',
      page: MainScreen,
      name: 'MainRouter',
      children: [
        AutoRoute(
          path: 'connections',
          page: ConnectionPage,
          name: 'ConnectionsRouter',
          children: [
            AutoRoute(
              path: 'friends',
              page: FriendsTab,
              name: 'FriendsTabRouter',
              initial: true,
            ),
            AutoRoute(
              path: 'notifications',
              page: NotificationsTab,
              name: 'NotificationsTabRouter',
            ),
          ],
        ),
        AutoRoute(
          path: 'home',
          page: HomePage,
          name: 'HomeRouter',
          initial: true,
        ),
        AutoRoute(
          path: 'settings',
          page: SettingsPage,
          name: 'SettingsRouter',
          // children: [
          //   AutoRoute(
          //     path: 'profile',
          //     page: ProfileSettingsScreen,
          //     name: 'ProfileSettingsRouter',
          //   ),
          //   AutoRoute(
          //     path: 'appearance',
          //     page: AppearanceSettingsAcreen,
          //     name: 'AppearanceSettingsRouter',
          //   ),
          //   AutoRoute(
          //     path: 'language',
          //     page: LanguageSettingsScreen,
          //     name: 'LanguageSettingsRouter',
          //   ),
          // ],
        ),
        // AutoRoute(
        //   path: 'profile',
        //   page: ProfileSettingsScreen,
        //   name: 'ProfileSettingsRouter',
        // ),
        // AutoRoute(
        //   path: 'appearance',
        //   page: AppearanceSettingsAcreen,
        //   name: 'AppearanceSettingsRouter',
        // ),
        // AutoRoute(
        //   path: 'language',
        //   page: LanguageSettingsScreen,
        //   name: 'LanguageSettingsRouter',
        // ),
      ],
    ),
    // try to change routes under to nested architecture -----------------------
    AutoRoute(
      path: 'profileSettings',
      page: ProfileSettingsScreen,
      name: 'ProfileSettingsRouter',
    ),
    AutoRoute(
      path: 'appearanceSettings',
      page: AppearanceSettingsAcreen,
      name: 'AppearanceSettingsRouter',
    ),
    AutoRoute(
      path: 'languageSettings',
      page: LanguageSettingsScreen,
      name: 'LanguageSettingsRouter',
    ),
    // -------------------------------------------------------------------------
    AutoRoute(
      path: '/waitingRoom',
      page: WaitingRoomScreen,
      name: 'WaitingRoomRouter',
    ),
    AutoRoute(
      path: '/offlineGame',
      page: OfflineGameScreen,
      name: 'OfflineGameRouter',
    ),
    AutoRoute(
      path: '/onlineGame',
      page: OnlineGameScreen,
      name: 'OnlineGameRouter',
    ),
    AutoRoute(
      path: '/notExisting',
      page: NotExistingScreen,
      name: 'NotExistingRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/loading',
      page: LoadingScreen,
      name: 'LoadingRouter',
      maintainState: false,
    ),
  ],
)
class $AppRouter {}

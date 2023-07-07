import 'package:auto_route/auto_route.dart';
import 'package:game/presentation/screens/add_friend_screen/add_friend_screen.dart';
import 'package:game/presentation/screens/choose_friend_for_game_screen/choose_friend_for_game_screen.dart';
import 'package:game/presentation/screens/auth_screens/signin_screen.dart';
import 'package:game/presentation/screens/auth_screens/registration_screen.dart';
import 'package:game/presentation/screens/game_rules_screen/game_rules_screen.dart';
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
import 'package:game/presentation/screens/settings_screens/settings_register_screen/settings_register_screen.dart';

@CustomAutoRouter(
  durationInMilliseconds: 300,
  reverseDurationInMilliseconds: 300,
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
    // Authentication screens.
    AutoRoute(
      path: '/signin',
      page: SignInScreen,
      name: 'SignInRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/registration',
      page: RegistrationScreen,
      name: 'RegistrationRouter',
      maintainState: false,
    ),
    // Main screens.
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
        ),
      ],
    ),
    // Setting screens.
    AutoRoute(
      path: '/profileSettings',
      page: ProfileSettingsScreen,
      name: 'ProfileSettingsRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/appearanceSettings',
      page: AppearanceSettingsScreen,
      name: 'AppearanceSettingsRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/languageSettings',
      page: LanguageSettingsScreen,
      name: 'LanguageSettingsRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/settingsRegister',
      page: SettingsRegisterScreen,
      name: 'SettingsRegisterRouter',
      maintainState: false,
    ),
    // Game screens.
    AutoRoute(
      path: '/waitingRoom',
      page: WaitingRoomScreen,
      name: 'WaitingRoomRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/offlineGame',
      page: OfflineGameScreen,
      name: 'OfflineGameRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/onlineGame',
      page: OnlineGameScreen,
      name: 'OnlineGameRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/gameRules',
      page: GameRulesScreen,
      name: 'GameRulesRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/addFiend',
      page: AddFriendScreen,
      name: 'AddFriendRouter',
      maintainState: false,
    ),
    AutoRoute(
      path: '/choosefriendForGame',
      page: ChoosefriendForGameScreen,
      name: 'ChoosefriendForGameRouter',
      maintainState: false,
    ),
    // Another screens.
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

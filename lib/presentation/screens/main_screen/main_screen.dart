import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/screens/main_screen/custom_bottom_navigation_bar.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/widgets/custom_popups/show_notification_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final RoomBloc roomBloc = context.read<RoomBloc>();
    final RoomState roomState = context.read<RoomBloc>().state;

    final InternetConnectionState internetConnectionState =
        context.read<InternetConnectionBloc>().state;

    // Leaves a game room if there is no Internet connection and the current user was in a game.
    if (internetConnectionState is DisconnectedInternetConnectionState &&
        (roomState is InRoomState || roomState is InFullRoomState)) {
      roomBloc.add(LeaveRoomEvent(
        gameRoom: roomBloc.state.getGameRoom()!,
        leaveWithLoose: false,
      ));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Displays an error message if needed after loading the page.
      if (roomState is ErrorRoomState) {
        log('roomError in the main screen');

        // Checks if error message has to be shown.
        final GameRoomError gameRoomError = roomState.gameRoomError;
        final bool showPopupWithBasicSentences =
            gameRoomError is! GameRoomErrorDeletingRoom &&
                gameRoomError is! GameRoomErrorNotTwoPlayers;

        // Displays an error message if needed.
        if (showPopupWithBasicSentences) {
          showNotificationPopUp(
            context: context,
            popUpTitle: AppLocalizations.of(context)!.roomError,
            popUpText:
                AppLocalizations.of(context)!.someKindOfRoomErrorHasOccured,
            buttonText: AppLocalizations.of(context)!.ok,
          );
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Changes the current user account online state base on the app activiness observing.

    // Online.
    if (state == AppLifecycleState.resumed) {
      context
          .read<AccountBloc>()
          .add(const ChangeOnlineStateAccountEvent(isOnline: true));
    }
    // Offline.
    else {
      context
          .read<AccountBloc>()
          .add(const ChangeOnlineStateAccountEvent(isOnline: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        // Closes the app activiness observing and navigates to the sign in screen
        // if the user is logged out.
        if (authState is LoggedOutAuthState) {
          log('main screen ------------------ go to the sign in screen');
          log('Close activiness observing');
          WidgetsBinding.instance.removeObserver(this);
          AutoRouter.of(context).replaceAll(const [SignInRouter()]);
        }
      },
      child: BlocListener<RoomBloc, RoomState>(
        listener: (context, roomState) {
          log('main screen --------- state //');

          // Navigates user to the waiting room screen.
          if (roomState is SearchingRoomState) {
            log('main screen ------------------ go to the waiting room screen');
            AutoRouter.of(context).replaceAll(const [WaitingRoomRouter()]);
          }

          // Navigates user to the waiting room screen.
          else if (roomState is InRoomState) {
            log('main screen ------------------ go to the waiting room screen when the room is created');
            AutoRouter.of(context).replaceAll(const [WaitingRoomRouter()]);
          }

          // Navigates to the online game room screen if the game room is full.
          else if (roomState is InFullRoomState) {
            log('main screen ------------------ go to the online game room screen');
            AutoRouter.of(context).replaceAll(const [OnlineGameRouter()]);
          }

          // Displays an error message if needed.
          else if (roomState is ErrorRoomState) {
            log('roomError in the main screen');

            // Checks if error message has to be shown.
            final GameRoomError gameRoomError = roomState.gameRoomError;
            final bool showPopupWithBasicSentences =
                gameRoomError is! GameRoomErrorDeletingRoom &&
                    gameRoomError is! GameRoomErrorNotTwoPlayers;

            // Displays an error message if needed.
            if (showPopupWithBasicSentences) {
              showNotificationPopUp(
                context: context,
                popUpTitle: AppLocalizations.of(context)!.roomError,
                popUpText:
                    AppLocalizations.of(context)!.someKindOfRoomErrorHasOccured,
                buttonText: AppLocalizations.of(context)!.ok,
              );
            }
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: backgroundTheme.color,
            body: AutoTabsRouter(
              routes: const [
                ConnectionsRouter(),
                HomeRouter(),
                SettingsRouter(),
              ],
              curve: Curves.easeInOutCirc,
              duration: const Duration(milliseconds: 500),
              lazyLoad: false,
              builder: (context, child, animation) {
                return Scaffold(
                  body: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  bottomNavigationBar: const CustomBottomNavigationBar(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

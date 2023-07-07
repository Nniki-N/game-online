import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/main_screen/custom_bottom_navigation_bar.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        // Closes the app activiness observing and navigates to the sign in screen
        // if the user is logged out.
        if (authState is LoggedOutAuthState) {
          log('main screen------------------ go to the sign in screen');
          log('Close activiness observing');
          WidgetsBinding.instance.removeObserver(this);
          AutoRouter.of(context).replaceAll(const [SignInRouter()]);
        }
      },
      child: BlocListener<RoomBloc, RoomState>(
        listener: (context, roomState) {
          // Navigates user to the waiting room screen.
          if (roomState is SearchingRoomState) {
            AutoRouter.of(context).replace(const WaitingRoomRouter());
          }

          // Displays an error message if an error occurs.
          else if (roomState is ErrorRoomState) {
            log('roomError in the main screen');
            showNotificationDialog(
              context: context,
              dialogTitle: roomState.errorTitle,
              dialogContent: roomState.errorText,
              buttonText: 'Ok',
            );
          }
        },
        child: Scaffold(
          backgroundColor: CustomColors.backgroundColor,
          body: AutoTabsRouter(
            routes: const [
              ConnectionsRouter(),
              HomeRouter(),
              SettingsRouter(),
            ],
            builder: (context, child, animation) {
              return Scaffold(
                body: child,
                bottomNavigationBar: const CustomBottomNavigationBar(),
              );
            },
          ),
        ),
      ),
    );
  }
}

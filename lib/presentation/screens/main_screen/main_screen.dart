import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/main_screen/custom_bottom_navigation_bar.dart';
import 'package:game/presentation/widgets/dialogs/show_notification_dialog.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, roomState) {
        // Navigates user to the waiting room screen.
        if (roomState is SearchingRoomState) {
          AutoRouter.of(context).replace(const WaitingRoomRouter());
        }

        // Displays an error message if an error accurs.
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
    );
  }
}

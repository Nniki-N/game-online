import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (content, authState) {
        // Navigates to the login screen if an error occurs.
        final authError = authState.error;
        if (authError != null) {
          log('error signin');
          AutoRouter.of(context).replace(const SignInRouter());
        }

        // Navigates to the main screen if the user is logged in.
        if (authState is LoggedInAuthState) {
          log('initial ------------------ go to main');
          context.read<AccountBloc>().add(const InitializeAccountEvent());
          context.read<FriendsBloc>().add(const InitializeFriendsEvent());
          context
              .read<NotificationBloc>()
              .add(const InitializeNotificationEvent());
          AutoRouter.of(context).replace(const MainRouter());
        }

        // Navigates to the login screen if the user is logged out.
        if (authState is LoggedOutAuthState) {
          log('initial ------------------ go to signin');
          AutoRouter.of(context).replace(const SignInRouter());
        }
      },
      child: LoadingScreen(
        backgroundColor: backgroundTheme.color2,
        animationWidgetColor: Colors.white,
      ),
    );
  }
}

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';

import '../../bloc/auth_bloc.dart/auth_bloc.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (content, state) {
        // navigates to the login screen if an error accurs
        final authError = state.error;
        if (authError != null) {
          log('error initial');
          AutoRouter.of(context).replace(const LoginRouter());
        }

        // navigates to the main screen if the user is logged in
        if (state is LoggedInAuthState) {
          log('initial ------------------ go to main');
          AutoRouter.of(context).replace(const MainRouter());
        }

        // navigates to the login screen if the user is logged out
        if (state is LoggedOutAuthState) {
          log('initial ------------------ go to login');
          AutoRouter.of(context).replace(const LoginRouter());
        }
      },
      builder: (content, state) {
        return const LoadingScreen();
      },
    );
  }
}

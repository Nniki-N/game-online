import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';


class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (content, state) {
        // navigates to the login screen if an error accurs
        final authError = state.error;
        if (authError != null) {
          log('error signin');
          AutoRouter.of(context).replace(const SignInRouter());
        }

        // navigates to the main screen if the user is logged in
        if (state is LoggedInAuthState) {
          log('initial ------------------ go to main');
          AutoRouter.of(context).replace(const MainRouter());
        }

        // navigates to the login screen if the user is logged out
        if (state is LoggedOutAuthState) {
          log('initial ------------------ go to signin');
          AutoRouter.of(context).replace(const SignInRouter());
        }
      },
      child: const LoadingScreen(),
    );
  }
}

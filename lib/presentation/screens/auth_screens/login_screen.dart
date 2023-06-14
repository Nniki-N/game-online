import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:game/presentation/widgets/dialogs/show_auth_error.dart';
import 'package:game/presentation/widgets/loading_overlay/loading_overlay.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: 'user1@gmail.com');
    final passwordController = TextEditingController(text: '12345678');

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (content, state) {
          // shows loading
          if (state is LoadingAuthState) {
            log('login ------------------ show loading');
            LoadingOverlay.instance().show(
              context: context,
              text: 'Loading...',
            );
          } else {
            log('login ------------------ hide loading');
            LoadingOverlay.instance().hide();
          }

          // displays an error message if an error accurs
          final authError = state.error;
          if (authError != null) {
            log('error login');
            showAuthError(
              context: context,
              authError: authError,
            );
          }

          // navigates to the main screen if the user is logged in
        if (state is LoggedInAuthState) {
          log('login ------------------ go to main');
          // LoadingOverlay.instance().hide();
          AutoRouter.of(context).replace(const MainRouter());
        }
        },
        builder: (context, state) {
          // if (state is LoadingAuthState) {
          //   return const LoadingScreen();
          // }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Log in'),
                      TextButton(
                        onPressed: () {
                          log('login ------------------ go to registration');
                          AutoRouter.of(context)
                              .replace(const RegistrationRouter());
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      log('login ------------------ log in button');
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isNotEmpty && password.isNotEmpty) {
                        context.read<AuthBloc>().add(
                              LogInAuthEvent(
                                email: email,
                                password: password,
                              ),
                            );
                      }
                    },
                    child: const Text('Log in'),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const LogInAnonymouslyAuthEvent());
                    },
                    child: const Text('Log in anonymously'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const LogInWithGoogleAuthEvent());
                    },
                    child: const Text('Log in with Google'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

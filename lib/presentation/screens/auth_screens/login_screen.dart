import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';
import 'package:game/presentation/widgets/loading_overlay.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: 'user1@gmail.com');
    final passwordController = TextEditingController(text: '12345678');

    final AuthBloc authBloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (content, state) {
        // displays an error message if an error accurs
        final error = state.error;
        if (error != null) {
          AutoRouter.of(context).navigate(const LoginRouter());
        }

        // shows loading
        if (state is LoadingAuthState) {
          LoadingOverlay.instance().show(
            context: context,
            text: 'Loading...',
          );
        } else {
          LoadingOverlay.instance().hide();
        }
      },
      builder: (context, state) {
        // if (state is LoadingAuthState) {
        //   return const LoadingScreen();
        // }

        return Scaffold(
          body: Center(
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
                          AutoRouter.of(context)
                              .navigate(const RegistrationRouter());
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
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isNotEmpty && password.isNotEmpty) {
                        authBloc.add(
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
                      authBloc.add(const LogInAnonymouslyAuthEvent());
                    },
                    child: const Text('Log in anonymously'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      authBloc.add(const LogInWithGoogleAuthEvent());
                    },
                    child: const Text('Log in with Google'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';
import 'package:game/presentation/widgets/loading_overlay.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(text: 'User1');
    final loginController = TextEditingController(text: 'user1');
    final emailController = TextEditingController(text: 'user1@gmail.com');
    final passwordController = TextEditingController(text: '12345678');
    final repeatPasswordasswordController =
        TextEditingController(text: '12345678');

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
                      const Text('Register'),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).navigate(const LoginRouter());
                        },
                        child: const Text('Log in'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: loginController,
                    decoration: const InputDecoration(hintText: 'Login'),
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
                  TextField(
                    controller: repeatPasswordasswordController,
                    decoration:
                        const InputDecoration(hintText: 'Repeat password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text.trim();
                      final login = loginController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final repeatPassword =
                          repeatPasswordasswordController.text.trim();

                      if (username.isNotEmpty &&
                          login.isNotEmpty &&
                          email.isNotEmpty &&
                          password.isNotEmpty &&
                          password == repeatPassword) {
                        final RegisterAuthEvent event = RegisterAuthEvent(
                          email: email,
                          password: password,
                          username: username,
                          login: login,
                        );

                        authBloc.add(event);
                      }
                    },
                    child: const Text('Register'),
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

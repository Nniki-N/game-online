import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';
import 'package:game/presentation/widgets/dialogs/show_delete_account_dialog.dart';
import 'package:game/presentation/widgets/dialogs/show_logout_dialog.dart';
import 'package:game/presentation/widgets/loading_overlay.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

        // navigates to the login screen if the user is logged out
        if (state is LoggedOutAuthState) {
          AutoRouter.of(context).navigate(const LoginRouter());
        }
      },
      builder: (context, state) {
        // if (state is LoadingAuthState) {
        //   return const LoadingScreen();
        // }

        return Scaffold(
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Main screen',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),

              // displays fields to link anonymous user with email and password
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final emailController =
                      TextEditingController(text: 'userAnon@gmail.com');
                  final passwordController =
                      TextEditingController(text: '12345678');

                  return !state.isAnonymousUser()
                      ? const SizedBox.shrink()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: passwordController,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                if (email.isNotEmpty && password.isNotEmpty) {
                                  authBloc.add(
                                    RegisterAnonymousUserAuthEvent(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                                }
                              },
                              child: const Text('Register anonymous user'),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final bool logout = await showLogOutDialog(
                    context: context,
                  );

                  if (logout) authBloc.add(const LogOutAuthEvent());
                },
                child: const Text('Log Out'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final bool delete = await showDeleteAccountDialog(
                    context: context,
                  );

                  if (delete) authBloc.add(const DeleteAccountAuthEvent());
                },
                child: const Text('Delete Account'),
              ),
            ],
          )),
        );
      },
    );
  }
}

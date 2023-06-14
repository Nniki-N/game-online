import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_state.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.image,
            size: 50,
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Username',
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Login',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('Save changes'),
          ),
          const Divider(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (!authState.isAnonymousUser()) {
                return const SizedBox.shrink();
              }

              return ElevatedButton(
                onPressed: () {
                  //
                },
                child: const Text('Register'),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

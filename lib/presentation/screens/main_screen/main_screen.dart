// ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
// import 'package:game/presentation/bloc/auth_bloc.dart/auth_bloc.dart';
// import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';
// import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';
// import 'package:game/presentation/widgets/dialogs/show_auth_error.dart';
// import 'package:game/presentation/widgets/dialogs/show_delete_account_dialog.dart';
// import 'package:game/presentation/widgets/dialogs/show_logout_dialog.dart';
// import 'package:game/presentation/widgets/loading_overlay/loading_overlay.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: BlocConsumer<AuthBloc, AuthState>(
    //     listener: (content, state) {
    //       // shows loading
    //       if (state is LoadingAuthState) {
    //         log('main ------------------ show loading');
    //         LoadingOverlay.instance().show(
    //           context: context,
    //           text: 'Loading...',
    //         );
    //       } else {
    //         log('main ------------------ hide loading');
    //         LoadingOverlay.instance().hide();
    //       }
//
    //       // displays an error message if an error accurs
    //       final authError = state.error;
    //       if (authError != null) {
    //         log('error login');
    //         showAuthError(
    //           context: context,
    //           authError: authError,
    //         );
    //       }
//
    //       // navigates to the login screen if the user is logged out
    //       if (state is LoggedOutAuthState) {
    //         // LoadingOverlay.instance().hide();
    //         AutoRouter.of(context).replace(const LoginRouter());
    //       }
    //     },
    //     builder: (context, state) {
    //       // if (state is LoadingAuthState) {
    //       //   return const LoadingScreen();
    //       // }
//
    //       return Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             const Text(
    //               'Main screen',
    //               style: TextStyle(
    //                 fontSize: 25,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
//
    //             // displays fields to link anonymous user with email and password
    //             BlocBuilder<AuthBloc, AuthState>(
    //               builder: (context, state) {
    //                 final emailController =
    //                     TextEditingController(text: 'userAnon@gmail.com');
    //                 final passwordController =
    //                     TextEditingController(text: '12345678');
//
    //                 return !state.isAnonymousUser()
    //                     ? const SizedBox.shrink()
    //                     : Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           const SizedBox(height: 20),
    //                           TextField(
    //                             controller: emailController,
    //                             decoration:
    //                                 const InputDecoration(hintText: 'Email'),
    //                           ),
    //                           const SizedBox(height: 20),
    //                           TextField(
    //                             controller: passwordController,
    //                             decoration:
    //                                 const InputDecoration(hintText: 'Password'),
    //                           ),
    //                           const SizedBox(height: 20),
    //                           ElevatedButton(
    //                             onPressed: () {
    //                               final email = emailController.text.trim();
    //                               final password =
    //                                   passwordController.text.trim();
//
    //                               if (email.isNotEmpty && password.isNotEmpty) {
    //                                 context.read<AuthBloc>().add(
    //                                   RegisterAnonymousUserAuthEvent(
    //                                     email: email,
    //                                     password: password,
    //                                   ),
    //                                 );
    //                               }
    //                             },
    //                             child: const Text('Register anonymous user'),
    //                           ),
    //                           const SizedBox(height: 20),
    //                         ],
    //                       );
    //               },
    //             ),
//
    //             const SizedBox(height: 20),
    //             ElevatedButton(
    //               onPressed: () async {
    //                 final bool logout = await showLogOutDialog(
    //                   context: context,
    //                 );
//
    //                 if (logout) context.read<AuthBloc>().add(const LogOutAuthEvent());
    //               },
    //               child: const Text('Log Out'),
    //             ),
    //             const SizedBox(height: 20),
    //             ElevatedButton(
    //               onPressed: () async {
    //                 final bool delete = await showDeleteAccountDialog(
    //                   context: context,
    //                 );
//
    //                 if (delete) context.read<AuthBloc>().add(const DeleteAccountAuthEvent());
    //               },
    //               child: const Text('Delete Account'),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );

    return Scaffold(
      body: AutoTabsRouter(
        routes: const [
          ConnectionsRouter(),
          HomeRouter(),
          SettingsRouter(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = context.tabsRouter;

          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.rate_review),
                  label: 'Connections',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.gamepad),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settinhs',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

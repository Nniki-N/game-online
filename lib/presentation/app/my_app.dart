import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: getIt(),
          )..add(const InitializeAuthEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Game',
        debugShowCheckedModeBanner: false,
        routerDelegate: getIt<AppRouter>().delegate(),
        routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
        builder: (context, router) => router!,
      ),
    );
  }
}

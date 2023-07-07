import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AuthBloc(
                  authRepository: getIt(),
                  accountRepository: getIt()
                )..add(const InitializeAuthEvent()),
              ),
              BlocProvider(
                create: (_) => RoomBloc(
                  roomRepository: getIt(),
                  accountRepository: getIt(),
                )..add(const InitializeRoomEvent()),
              ),
              BlocProvider(
                create: (_) => AccountBloc(
                  accountRepository: getIt(),
                ),
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
        });
  }
}

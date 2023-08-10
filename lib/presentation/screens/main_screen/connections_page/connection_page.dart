import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';
import 'package:game/presentation/screens/main_screen/connections_page/connections_tab_bar.dart';
import 'package:game/presentation/screens/no_internet_connection_screen/no_internet_connection_screen.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionBloc, InternetConnectionState>(
      builder: (context, internetConnectionState) {
        if (internetConnectionState is DisconnectedInternetConnectionState) {
          return const NoInternetConnectionScreen();
        }

        return AutoTabsRouter(
          routes: const [
            FriendsTabRouter(),
            NotificationsTabRouter(),
          ],
          lazyLoad: false,
          curve: Curves.easeInOutCirc,
          duration: const Duration(milliseconds: 500),
          builder: (context, child, animation) {
            return Padding(
              padding: EdgeInsets.only(
                top: 45.h,
                left: 30.w,
                right: 30.w,
              ),
              child: Column(
                children: [
                  const ConnectionsTabBar(),
                  SizedBox(height: 25.h),
                  Expanded(child: child),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

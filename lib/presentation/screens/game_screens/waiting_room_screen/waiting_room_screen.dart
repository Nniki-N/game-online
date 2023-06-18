import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is InFullRoomState) {
          log('waiting room ------------------ go to online game room');
          AutoRouter.of(context).replace(const OnlineGameRouter());
        }

        if (state is OutsideRoomState) {
          log('waiting room ------------------ go to main');
          AutoRouter.of(context).replace(const MainRouter());
        }

        if (state is ErrorRoomState) {
          log('waiting room via error------------------ go to main');
          AutoRouter.of(context).replace(const MainRouter());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 50,
                    ),
                    const Text('Room was created'),
                    const Text(
                      'The second player is in the search, please wait a bit...',
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .navigate(const OnlineGameRouter());
                      },
                      child: const Text('Go to online game room'),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

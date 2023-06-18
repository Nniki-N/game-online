import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.image, size: 200),
          const Text('Tic Tac Toe'),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).navigate(const OfflineGameRouter());
            },
            child: const Text('Play on one device'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              // searching for a room
              // creates a room if there are no rooms
              final RoomBloc roomBloc = context.read<RoomBloc>();
              roomBloc.add(const SearchRoomEvent());

              // temporary method of navigating to the eaiting room
              AutoRouter.of(context).navigate(const WaitingRoomRouter());
            },
            child: const Text('Play with a random player'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              // AutoRouter.of(context).navigate(const WaitingRoomRouter());
            },
            child: const Text('Play with a friend'),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              //
            },
            child: const Text('Game rules'),
          ),
        ],
      ),
    );
  }
}

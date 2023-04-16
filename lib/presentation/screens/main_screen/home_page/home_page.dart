import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:game/common/navigation/app_router.gr.dart';

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
              AutoRouter.of(context).navigate(const WaitingRoomRouter());
            },
            child: const Text('Play on one device'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).navigate(const WaitingRoomRouter());
            },
            child: const Text('Play on one device'),
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

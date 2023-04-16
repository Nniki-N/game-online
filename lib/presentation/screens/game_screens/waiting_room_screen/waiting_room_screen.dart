import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

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
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image,
                  size: 50,
                ),
                Text('Room was created'),
                Text(
                    'The second player is in the search, please wait a bit...'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

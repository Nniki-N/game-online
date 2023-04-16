import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NotExistingScreen extends StatelessWidget {
  const NotExistingScreen({super.key});

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
                Text('This page does not exists'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

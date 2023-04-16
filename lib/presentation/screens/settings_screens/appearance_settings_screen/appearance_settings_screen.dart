
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppearanceSettingsAcreen extends StatelessWidget {
  const AppearanceSettingsAcreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                  const Text('light'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                  const Text('dark'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('authomatic'),
                ],
              ),
              Text('Sets theme based on your device’s appearance mode')
            ],
          )
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

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
          ListView(
            shrinkWrap: true,
            children: const [
              Row(
                children: [
                  Text('English'),
                  Icon(Icons.arrow_downward),
                ],
              ),
              Text('Ukrainian'),
            ],
          )
        ],
      ),
    );
  }
}

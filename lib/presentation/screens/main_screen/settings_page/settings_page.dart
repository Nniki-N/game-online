import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:game/common/navigation/app_router.gr.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                log('tap');

                AutoRouter.of(context).push(const ProfileSettingsRouter());
              },
              child: Container(
                color: Colors.grey,
                child: const Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.image,
                      size: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text('nickname'),
                        Text('login'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                // navigates to the language settings screen
                AutoRouter.of(context).push(const LanguageSettingsRouter());
              },
              child: Container(
                color: Colors.grey,
                child: const Row(
                  children: [
                    Text('language'),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                // navigates to the profile appearance screen
                AutoRouter.of(context).push(const AppearanceSettingsRouter());
              },
              child: Container(
                color: Colors.grey,
                child: const Row(
                  children: [
                    Text('appearance'),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Slider(
              value: 100,
              min: 0,
              max: 100,
              divisions: 100,
              label: 'background music',
              onChanged: (value) {
                //
              },
            ),
            const SizedBox(height: 15),
            Slider(
              value: 100,
              min: 0,
              max: 100,
              divisions: 100,
              label: 'sound effects',
              onChanged: (value) {
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}

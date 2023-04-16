import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class OfflineGameScreen extends StatelessWidget {
  const OfflineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: Container(
              color: Colors.grey,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black12,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('3x'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black12,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('3x'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black12,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('3x'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    child: const Text('Give up'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    child: const Text('Leave'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: const Text('56:00'),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Placeholder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  child: const Text('Give up'),
                ),
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  child: const Text('Leave'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: const Text('56:00'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.black12,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 5),
                      const Text('3x'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.black12,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 5),
                      const Text('3x'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.black12,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 5),
                      const Text('3x'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

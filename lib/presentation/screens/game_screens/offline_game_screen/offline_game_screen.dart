import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/game_screens/field.dart';
import 'package:game/presentation/screens/game_screens/offline_hips_row.dart';
import 'package:game/presentation/screens/game_screens/row_with_buttons.dart';
import 'package:game/resources/resources.dart';

// class OfflineGameScreen extends StatelessWidget {
//   const OfflineGameScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           RotatedBox(
//             quarterTurns: 2,
//             child: Container(
//               color: Colors.grey,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           color: Colors.black12,
//                           width: 30,
//                           height: 30,
//                         ),
//                         const SizedBox(width: 5),
//                         const Text('3x'),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           color: Colors.black12,
//                           width: 30,
//                           height: 30,
//                         ),
//                         const SizedBox(width: 5),
//                         const Text('3x'),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           color: Colors.black12,
//                           width: 30,
//                           height: 30,
//                         ),
//                         const SizedBox(width: 5),
//                         const Text('3x'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           RotatedBox(
//             quarterTurns: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       AutoRouter.of(context).pop();
//                     },
//                     child: const Text('Give up'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       AutoRouter.of(context).pop();
//                     },
//                     child: const Text('Leave'),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1,
//                       ),
//                     ),
//                     child: const Text('56:00'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Expanded(
//             child: Center(
//               child: Placeholder(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     AutoRouter.of(context).pop();
//                   },
//                   child: const Text('Give up'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     AutoRouter.of(context).pop();
//                   },
//                   child: const Text('Leave'),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1,
//                     ),
//                   ),
//                   child: const Text('56:00'),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.grey,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         color: Colors.black12,
//                         width: 30,
//                         height: 30,
//                       ),
//                       const SizedBox(width: 5),
//                       const Text('3x'),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         color: Colors.black12,
//                         width: 30,
//                         height: 30,
//                       ),
//                       const SizedBox(width: 5),
//                       const Text('3x'),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         color: Colors.black12,
//                         width: 30,
//                         height: 30,
//                       ),
//                       const SizedBox(width: 5),
//                       const Text('3x'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OfflineGameScreen extends StatelessWidget {
  const OfflineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RotatedBox(
            quarterTurns: 2,
            child: OfflineChipsRow(
              svgPicturePath: Svgs.chipRed,
            ),
          ),
          SizedBox(height: 20.h),
          const RotatedBox(
            quarterTurns: 2,
            child: RowWithButtons(),
          ),
          const Field(),
          const RowWithButtons(),
          SizedBox(height: 20.h),
          const OfflineChipsRow(
            svgPicturePath: Svgs.chipCyan,
          ),
        ],
      ),
    );
  }
}

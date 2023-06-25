import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/screens/main_screen/connections_page/connections_tab_bar.dart';

// class ConnectionPage extends StatelessWidget {
//   const ConnectionPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   //
//                 },
//                 child: const Text('Friends and me'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   //
//                 },
//                 child: const Text('Notifications'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           TextButton(
//             onPressed: () {
//               //
//             },
//             child: const Text('Add friend'),
//           ),
//           const SizedBox(height: 15),
//           SingleChildScrollView(
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Container(
//                     color: Colors.grey,
//                     child: Row(
//                       children: [
//                         const Icon(Icons.image, size: 40),
//                         const SizedBox(width: 10),
//                         const Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text('username'),
//                             Row(
//                               children: [
//                                 Text('Total games: 0'),
//                                 SizedBox(width: 10),
//                                 Text('Victories: 0'),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           onPressed: () {
//                             //
//                           },
//                           icon: const Icon(Icons.menu),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.grey,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.image),
//                       const SizedBox(width: 19),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text('username'),
//                           const Row(
//                             children: [
//                               Text('Total games: 0'),
//                               Text('Victories: 0'),
//                             ],
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 //
//                               },
//                               icon: const Icon(Icons.menu))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   color: Colors.grey,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.image),
//                       const SizedBox(width: 19),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text('username'),
//                           const Row(
//                             children: [
//                               Text('Total games: 0'),
//                               Text('Victories: 0'),
//                             ],
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 //
//                               },
//                               icon: const Icon(Icons.menu))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        FriendsTabRouter(),
        NotificationsTabRouter(),
      ],
      builder: (context, child, animation) {
        return Padding(
          padding: EdgeInsets.only(
            top: 45.h,
            left: 30.w,
            right: 30.w,
          ),
          child: Column(
            children: [
              const ConnectionsTabBar(),
              SizedBox(height: 25.h),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

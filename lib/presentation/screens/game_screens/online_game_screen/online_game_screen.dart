
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/game_screens/field.dart';
import 'package:game/presentation/screens/game_screens/online_footer.dart';
import 'package:game/presentation/screens/game_screens/online_header.dart';
import 'package:game/presentation/screens/game_screens/row_with_buttons.dart';

// class OnlineGameScreen extends StatefulWidget {
//   const OnlineGameScreen({super.key});
//
//   @override
//   State<OnlineGameScreen> createState() => _OnlineGameScreenState();
// }
//
// class _OnlineGameScreenState extends State<OnlineGameScreen> {
//   Chips? chipSize;
//
//   @override
//   Widget build(BuildContext context) {
//     final GameRoom gameRoom =
//         (context.read<RoomBloc>().state as InFullRoomState).gameRoom;
//
//     return BlocProvider(
//       create: (context) => GameBloc(
//         gameRepository: getIt(),
//         accountRepository: getIt(),
//         roomRepository: getIt(),
//         gameRoom: gameRoom.copyWith(),
//       )..add(const InitializeGameEvent()),
//       child: BlocConsumer<RoomBloc, RoomState>(
//         listener: (context, roomState) {
//           if (roomState is InRoomState) {
//             log('online game room ------------------ go to waiting room');
//             AutoRouter.of(context).replace(const WaitingRoomRouter());
//           }
//         },
//         builder: (context, roomState) {
//           return Scaffold(
//             body: Column(
//               children: [
//                 // Header
//                 Container(
//                   color: Colors.grey,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.image),
//                       const SizedBox(width: 10),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             color: Colors.black12,
//                             width: 30,
//                             height: 30,
//                           ),
//                           const SizedBox(width: 5),
//                           const Text('3x'),
//                         ],
//                       ),
//                       const SizedBox(width: 10),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             color: Colors.black12,
//                             width: 30,
//                             height: 30,
//                           ),
//                           const SizedBox(width: 5),
//                           const Text('3x'),
//                         ],
//                       ),
//                       const SizedBox(width: 10),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             color: Colors.black12,
//                             width: 30,
//                             height: 30,
//                           ),
//                           const SizedBox(width: 5),
//                           const Text('3x'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 // Field
//                 BlocConsumer<GameBloc, GameState>(
//                   listener: (context, gameState) {
//                     // log('listen in gamestate -------------- ');
//                   },
//                   builder: (context, gameState) {
//                     // log('build in gamestate -------------- ');
//
//                     return Expanded(
//                       child: Center(
//                         child: Container(
//                           padding: const EdgeInsets.all(20),
//                           child: GridView.builder(
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 5,
//                               mainAxisSpacing: 5,
//                             ),
//                             itemCount: 9,
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               late final int indexI;
//                               late final int indexJ;
//
//                               if (index == 0) {
//                                 indexI = 0;
//                                 indexJ = 0;
//                               } else if (index == 1) {
//                                 indexI = 0;
//                                 indexJ = 1;
//                               } else if (index == 2) {
//                                 indexI = 0;
//                                 indexJ = 2;
//                               } else if (index == 3) {
//                                 indexI = 1;
//                                 indexJ = 0;
//                               } else if (index == 4) {
//                                 indexI = 1;
//                                 indexJ = 1;
//                               } else if (index == 5) {
//                                 indexI = 1;
//                                 indexJ = 2;
//                               } else if (index == 6) {
//                                 indexI = 2;
//                                 indexJ = 0;
//                               } else if (index == 7) {
//                                 indexI = 2;
//                                 indexJ = 1;
//                               } else if (index == 8) {
//                                 indexI = 2;
//                                 indexJ = 2;
//                               }
//
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (chipSize == null) return;
//
//                                   final GameBloc gameBloc =
//                                       context.read<GameBloc>();
//
//                                   gameBloc.add(
//                                     MakeMoveGameEvent(
//                                       chipSize: chipSize!,
//                                       indexI: indexI,
//                                       indexJ: indexJ,
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: const BoxDecoration(
//                                     color: Color.fromARGB(255, 206, 206, 206),
//                                   ),
//                                   child: gameState.gameRoom
//                                               .fieldWithChips[indexI][indexJ] ==
//                                           null
//                                       ? Text(
//                                           index.toString(),
//                                         )
//                                       : Container(
//                                           color: Colors.blue,
//                                           width: gameState
//                                                       .gameRoom
//                                                       .fieldWithChips[indexI]
//                                                           [indexJ]!
//                                                       .chipSize
//                                                       .index *
//                                                   20 +
//                                               20,
//                                           height: gameState
//                                                       .gameRoom
//                                                       .fieldWithChips[indexI]
//                                                           [indexJ]!
//                                                       .chipSize
//                                                       .index *
//                                                   20 +
//                                               20,
//                                         ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 // Footer
//                 const SizedBox(height: 50),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           AutoRouter.of(context).pop();
//                         },
//                         child: const Text('Give up'),
//                       ),
//                       const SizedBox(width: 15),
//                       ElevatedButton(
//                         onPressed: () {
//                           final RoomBloc roomBloc = context.read<RoomBloc>();
//
//                           // leaves room
//                           roomBloc.add(
//                             LeaveRoomEvent(
//                               gameRoom: (roomState is InFullRoomState)
//                                   ? roomState.gameRoom
//                                   : (roomState as InRoomState).gameRoom,
//                               leaveAfterResult: false,
//                             ),
//                           );
//
//                           AutoRouter.of(context).pop();
//                         },
//                         child: const Text('Leave'),
//                       ),
//                       const SizedBox(width: 15),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1,
//                           ),
//                         ),
//                         child: const Text('56:00'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   color: Colors.grey,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                               onTap: () => chipSize = Chips.chipSize3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Container(
//                                   color: Colors.blue,
//                                   width: 60,
//                                   height: 60,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             const Text('3x'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                               onTap: () => chipSize = Chips.chipSize2,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Container(
//                                   color: Colors.blue,
//                                   width: 50,
//                                   height: 50,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             const Text('3x'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                               onTap: () => chipSize = Chips.chipSize1,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Container(
//                                   color: Colors.blue,
//                                   width: 40,
//                                   height: 40,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             const Text('3x'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class OnlineGameScreen extends StatelessWidget {
  const OnlineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OnlineHeader(),
          const Field(),
          const RowWithButtons(),
          SizedBox(height: 20.h),
          const OnlineFooter(),
        ],
      ),
    );
  }
}



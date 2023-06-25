import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double fieldSize = 315.w;
    final double fieldSpacing = 2.w;

    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Stack(
            children: [
              Container(
                width: fieldSize,
                height: fieldSize,
                decoration: BoxDecoration(
                  color: CustomColors.backgroundGreenGreyColor,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                clipBehavior: Clip.hardEdge,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: fieldSpacing,
                    mainAxisSpacing: fieldSpacing,
                  ),
                  itemCount: 9,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // late final int indexI;
                    // late final int indexJ;

                    // if (index == 0) {
                    //   indexI = 0;
                    //   indexJ = 0;
                    // } else if (index == 1) {
                    //   indexI = 0;
                    //   indexJ = 1;
                    // } else if (index == 2) {
                    //   indexI = 0;
                    //   indexJ = 2;
                    // } else if (index == 3) {
                    //   indexI = 1;
                    //   indexJ = 0;
                    // } else if (index == 4) {
                    //   indexI = 1;
                    //   indexJ = 1;
                    // } else if (index == 5) {
                    //   indexI = 1;
                    //   indexJ = 2;
                    // } else if (index == 6) {
                    //   indexI = 2;
                    //   indexJ = 0;
                    // } else if (index == 7) {
                    //   indexI = 2;
                    //   indexJ = 1;
                    // } else if (index == 8) {
                    //   indexI = 2;
                    //   indexJ = 2;
                    // }

                    return Container(
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.black, width: 1.5.w),
                      // ),
                    );

                    // return GestureDetector(
                    //   onTap: () {
                    //     if (chipSize == null) return;

                    //     final GameBloc gameBloc = context.read<GameBloc>();

                    //     gameBloc.add(
                    //       MakeMoveGameEvent(
                    //         chipSize: chipSize!,
                    //         indexI: indexI,
                    //         indexJ: indexJ,
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromARGB(255, 206, 206, 206),
                    //     ),
                    //     child:
                    //         gameState.gameRoom.fieldWithChips[indexI][indexJ] == null
                    //             ? Text(
                    //                 index.toString(),
                    //               )
                    //             : Container(
                    //                 color: Colors.blue,
                    //                 width: gameState
                    //                             .gameRoom
                    //                             .fieldWithChips[indexI][indexJ]!
                    //                             .chipSize
                    //                             .index *
                    //                         20 +
                    //                     20,
                    //                 height: gameState
                    //                             .gameRoom
                    //                             .fieldWithChips[indexI][indexJ]!
                    //                             .chipSize
                    //                             .index *
                    //                         20 +
                    //                     20,
                    //               ),
                    //   ),
                    // );
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: fieldSize / 3 - fieldSpacing / 2,
                child: Container(
                  height: fieldSize,
                  width: fieldSpacing,
                  color: CustomColors.mainMudColor,
                ),
              ),
              Positioned(
                top: 0,
                right: fieldSize / 3 - fieldSpacing / 2,
                child: Container(
                  height: fieldSize,
                  width: fieldSpacing,
                  color: CustomColors.mainMudColor,
                ),
              ),
              Positioned(
                left: 0,
                top: fieldSize / 3 - fieldSpacing / 2,
                child: Container(
                  height: fieldSpacing,
                  width: fieldSize,
                  color: CustomColors.mainMudColor,
                ),
              ),
              Positioned(
                left: 0,
                bottom: fieldSize / 3 - fieldSpacing / 2,
                child: Container(
                  height: fieldSpacing,
                  width: fieldSize,
                  color: CustomColors.mainMudColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

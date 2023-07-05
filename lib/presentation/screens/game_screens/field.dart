import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/bloc/game_bloc/game_event.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/resources/resources.dart';

class Field extends StatelessWidget {
  final Chips? chipSize;
  final VoidCallback setChipSizeAsZero;

  const Field({
    super.key,
    required this.chipSize,
    required this.setChipSizeAsZero,
  });

  @override
  Widget build(BuildContext context) {
    final double fieldSize = 315.w;
    final double fieldSpacing = 2.w;

    final GameBloc gameBloc = context.read<GameBloc>();
    final AccountBloc accountBloc = context.read<AccountBloc>();

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
                    late final int indexI;
                    late final int indexJ;

                    if (index == 0) {
                      indexI = 0;
                      indexJ = 0;
                    } else if (index == 1) {
                      indexI = 0;
                      indexJ = 1;
                    } else if (index == 2) {
                      indexI = 0;
                      indexJ = 2;
                    } else if (index == 3) {
                      indexI = 1;
                      indexJ = 0;
                    } else if (index == 4) {
                      indexI = 1;
                      indexJ = 1;
                    } else if (index == 5) {
                      indexI = 1;
                      indexJ = 2;
                    } else if (index == 6) {
                      indexI = 2;
                      indexJ = 0;
                    } else if (index == 7) {
                      indexI = 2;
                      indexJ = 1;
                    } else if (index == 8) {
                      indexI = 2;
                      indexJ = 2;
                    }

                    final fieldChip =
                        gameBloc.state.gameRoom.fieldWithChips[indexI][indexJ];

                    return GestureDetector(
                      onTap: () {
                        if (chipSize == null) return;

                        gameBloc.add(
                          MakeMoveGameEvent(
                            chipSize: chipSize!,
                            indexI: indexI,
                            indexJ: indexJ,
                          ),
                        );

                        setChipSizeAsZero();
                      },
                      behavior: HitTestBehavior.opaque,
                      // Chip or just empty field.
                      child: Container(
                        alignment: Alignment.center,
                        child: fieldChip == null
                            ? const SizedBox.shrink()
                            : SvgPicture.asset(
                                fieldChip.chipOfPlayerUid ==
                                        accountBloc.state.getUserAccount()!.uid
                                    ? Svgs.chipCyan
                                    : Svgs.chipRed,
                                width: fieldChip.chipSize.index * 15 + 30,
                              ),
                      ),
                    );
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

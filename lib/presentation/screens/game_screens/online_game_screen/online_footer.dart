import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';
import 'package:game/presentation/theme/extensions/chips_row_theme.dart';
import 'package:game/resources/resources.dart';

class OnlineFooter extends StatelessWidget {
  final void Function({required Chips chipSize}) onTap;

  const OnlineFooter({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = context.watch<GameBloc>();
    final AccountBloc accountBloc = context.watch<AccountBloc>();

    final GameRoom gameRoom = gameBloc.state.gameRoom;

    final Player player = gameRoom.players.firstWhere(
      (player) => player.uid == accountBloc.state.getUserAccount()!.uid,
    );

    final bool turnOfPlayer = player.uid == gameRoom.turnOfPlayerUid;

    final ChipsRowTheme chipsRowTheme = Theme.of(context).extension<ChipsRowTheme>()!;

    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: chipsRowTheme.backgroundColor,
      child: Center(
        child: Opacity(
          opacity: turnOfPlayer ? 1.0 : 0.65,
          child: RowWithChips(
            onTap: onTap,
            player: player,
            turnOfPlayer: turnOfPlayer,
          ),
        ),
      ),
    );
  }
}

class RowWithChips extends StatelessWidget {
  final void Function({required Chips chipSize}) onTap;
  final Player player;
  final bool turnOfPlayer;

  const RowWithChips({
    super.key,
    required this.onTap,
    required this.player,
    required this.turnOfPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (player.chipsCount[Chips.chipSize3]! >= 0 && turnOfPlayer) {
              onTap(chipSize: Chips.chipSize3);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Opacity(
            opacity: player.chipsCount[Chips.chipSize3]! >= 0 ? 1.0 : 0.65,
            child: PlayerChipsCountItem(
              chipsCount: player.chipsCount[Chips.chipSize3]!,
              svgPicture: SvgPicture.asset(
                Svgs.chipCyan,
                height: 42.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            if (player.chipsCount[Chips.chipSize2]! >= 0 && turnOfPlayer) {
              onTap(chipSize: Chips.chipSize2);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Opacity(
            opacity: player.chipsCount[Chips.chipSize2]! >= 0 ? 1.0 : 0.65,
            child: PlayerChipsCountItem(
              chipsCount: player.chipsCount[Chips.chipSize2] ?? 0,
              svgPicture: SvgPicture.asset(
                Svgs.chipCyan,
                height: 34.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            if (player.chipsCount[Chips.chipSize1]! >= 0 && turnOfPlayer) {
              onTap(chipSize: Chips.chipSize1);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Opacity(
            opacity: player.chipsCount[Chips.chipSize1]! >= 0 ? 1.0 : 0.65,
            child: PlayerChipsCountItem(
              chipsCount: player.chipsCount[Chips.chipSize1] ?? 0,
              svgPicture: SvgPicture.asset(
                Svgs.chipCyan,
                height: 28.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

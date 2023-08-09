import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/domain/entities/player.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/screens/game_screens/player_chips_count_item.dart';
import 'package:game/presentation/theme/extensions/chips_row_theme.dart';
import 'package:game/presentation/widgets/custom_avatar.dart';
import 'package:game/resources/resources.dart';

class OnlineHeader extends StatelessWidget {
  const OnlineHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ChipsRowTheme chipsRowTheme =
        Theme.of(context).extension<ChipsRowTheme>()!;

    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: chipsRowTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAvatar(
            size: 40.w,
          ),
          const RowWithOponentChips(),
        ],
      ),
    );
  }
}

class RowWithOponentChips extends StatelessWidget {
  const RowWithOponentChips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = context.watch<GameBloc>();
    final AccountBloc accountBloc = context.watch<AccountBloc>();

    final Player player = gameBloc.state.gameRoom.players.firstWhere(
      (player) => player.uid != accountBloc.state.getUserAccount()!.uid,
      orElse: () => const Player(
        uid: '',
        username: '',
        avatarLink: '',
        chipsCount: {
          Chips.chipSize1: 0,
          Chips.chipSize2: 0,
          Chips.chipSize3: 0,
        },
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerChipsCountItem(
          chipsCount: player.chipsCount[Chips.chipSize3] ?? 0,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 42.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: player.chipsCount[Chips.chipSize2] ?? 0,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 34.h,
          ),
        ),
        SizedBox(width: 20.w),
        PlayerChipsCountItem(
          chipsCount: player.chipsCount[Chips.chipSize1] ?? 0,
          svgPicture: SvgPicture.asset(
            Svgs.chipRed,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}

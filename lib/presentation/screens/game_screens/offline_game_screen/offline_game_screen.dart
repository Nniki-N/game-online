import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/game_screens/offline_game_screen/offline_chips_row.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/resources/resources.dart';

class OfflineGameScreen extends StatelessWidget {
  const OfflineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return Scaffold(
      backgroundColor: backgroundTheme.color,
      body: Column(
        children: [
          const RotatedBox(
            quarterTurns: 2,
            child: OfflineChipsRow(
              svgPicturePath: Svgs.chipRed,
            ),
          ),
          SizedBox(height: 20.h),
          // const RotatedBox(
          //   quarterTurns: 2,
          //   child: RowWithButtons(),
          // ),
          // Field(
          //   chipSize: null,
          //   setChipSizeAsZero: () {
          //     //
          //   },
          // ),
          // const RowWithButtons(),
          SizedBox(height: 20.h),
          const OfflineChipsRow(
            svgPicturePath: Svgs.chipCyan,
          ),
        ],
      ),
    );
  }
}

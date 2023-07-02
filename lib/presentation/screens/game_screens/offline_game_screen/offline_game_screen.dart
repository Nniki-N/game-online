import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/screens/game_screens/offline_hips_row.dart';
import 'package:game/presentation/screens/game_screens/row_with_buttons.dart';
import 'package:game/resources/resources.dart';

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
          // const Field(),
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

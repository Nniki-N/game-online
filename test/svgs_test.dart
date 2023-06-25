import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game/resources/resources.dart';

void main() {
  test('svgs assets test', () {
    expect(File(Svgs.addIcon).existsSync(), true);
    expect(File(Svgs.alertIcon).existsSync(), true);
    expect(File(Svgs.arrowBackIcon).existsSync(), true);
    expect(File(Svgs.arrowDownIcon).existsSync(), true);
    expect(File(Svgs.arrowForwardIcon).existsSync(), true);
    expect(File(Svgs.avatarBlue).existsSync(), true);
    expect(File(Svgs.avatarCyan).existsSync(), true);
    expect(File(Svgs.avatarGreen).existsSync(), true);
    expect(File(Svgs.avatarPurple).existsSync(), true);
    expect(File(Svgs.avatarRed).existsSync(), true);
    expect(File(Svgs.chipCyan).existsSync(), true);
    expect(File(Svgs.chipRed).existsSync(), true);
    expect(File(Svgs.connectionIcon).existsSync(), true);
    expect(File(Svgs.dotsIcon).existsSync(), true);
    expect(File(Svgs.gameIcon).existsSync(), true);
    expect(File(Svgs.gearIcon).existsSync(), true);
    expect(File(Svgs.gogleIcon).existsSync(), true);
    expect(File(Svgs.informIcon).existsSync(), true);
    expect(File(Svgs.logoIngameIcon).existsSync(), true);
    expect(File(Svgs.separatorMidleRectangleIcon).existsSync(), true);
  });
}

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game/resources/resources.dart';

void main() {
  test('svgs assets test', () {
    expect(File(Svgs.add).existsSync(), true);
    expect(File(Svgs.alert).existsSync(), true);
    expect(File(Svgs.arrowBack).existsSync(), true);
    expect(File(Svgs.arrowDown).existsSync(), true);
    expect(File(Svgs.arrowForward).existsSync(), true);
    expect(File(Svgs.avatarBlue).existsSync(), true);
    expect(File(Svgs.avatarCyan).existsSync(), true);
    expect(File(Svgs.avatarGreen).existsSync(), true);
    expect(File(Svgs.avatarPurple).existsSync(), true);
    expect(File(Svgs.avatarRed).existsSync(), true);
    expect(File(Svgs.chipCyan).existsSync(), true);
    expect(File(Svgs.chipRed).existsSync(), true);
    expect(File(Svgs.connection).existsSync(), true);
    expect(File(Svgs.dots).existsSync(), true);
    expect(File(Svgs.game).existsSync(), true);
    expect(File(Svgs.gear).existsSync(), true);
    expect(File(Svgs.gogle).existsSync(), true);
    expect(File(Svgs.inform).existsSync(), true);
    expect(File(Svgs.logoIngame).existsSync(), true);
    expect(File(Svgs.signInSeparator).existsSync(), true);
    expect(File(Svgs.splashScreen).existsSync(), true);
    expect(File(Svgs.splashScreen2).existsSync(), true);
  });
}

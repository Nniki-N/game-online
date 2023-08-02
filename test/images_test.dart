import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.splashIcon).existsSync(), true);
    expect(File(Images.splashScreen).existsSync(), true);
    expect(File(Images.splashScreen2).existsSync(), true);
  });
}

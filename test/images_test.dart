import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.logoBackground).existsSync(), true);
    expect(File(Images.logoForeground).existsSync(), true);
    expect(File(Images.logo).existsSync(), true);
    expect(File(Images.splashIcon).existsSync(), true);
  });
}

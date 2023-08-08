import 'dart:math';

import 'package:game/resources/resources.dart';

String selectRandomBasicAvatar() {
  final List<String> avatarsList = [
    Svgs.avatarBlue,
    Svgs.avatarCyan,
    Svgs.avatarGreen,
    Svgs.avatarPurple,
    Svgs.avatarRed,
  ];

  final Random random = Random();

  final int randomInt = random.nextInt(avatarsList.length);

  return avatarsList[randomInt];
}

final randomUserAvatar = selectRandomBasicAvatar();

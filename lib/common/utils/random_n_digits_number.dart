import 'dart:math';

int randomNDigitNumber({required int digitsCount}) {
  final Random random = Random();

  final int min = pow(10, digitsCount - 1) as int;
  final int max = (pow(10, digitsCount) - 1) as int;

  final int number = min + random.nextInt(max - min);

  return number;
}

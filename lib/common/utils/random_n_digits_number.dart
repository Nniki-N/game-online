import 'dart:math';

int randomNDigitNumber({required int digitsCount}) {
  final Random random = Random();

  return random.nextInt(9 * (pow(10, digitsCount - 1) as int)) +
      (pow(10, digitsCount - 1) as int);
}

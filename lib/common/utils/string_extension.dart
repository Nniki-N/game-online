extension StringExtension on String {
  String capitalize() {
    final String text = this;
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}

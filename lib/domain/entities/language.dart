import 'dart:ui';

enum Language {
  english(
    locale: Locale('en', 'US'),
    languageName: 'English',
  ),
  ukrainian(
    locale: Locale('uk', 'UKR'),
    languageName: 'Українська',
  );

  const Language({
    required this.locale,
    required this.languageName,
  });

  final Locale locale;
  final String languageName;
}

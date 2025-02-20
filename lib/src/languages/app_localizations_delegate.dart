import 'package:dio_nexus/src/languages/index.dart';
import 'package:flutter/material.dart';

/// The `AppLocalizationsDelegate` class is a `LocalizationsDelegate` implementation that provides
/// localized resources for the application.
class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  /// The constructor for the `AppLocalizationsDelegate` class.
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      [Language.en.name, Language.tr.name].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'tr':
        return LanguageTr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

/// The `Language` enum represents the supported languages in the application.
enum Language {
  /// English language.
  en,

  /// Turkish language.
  tr,
}

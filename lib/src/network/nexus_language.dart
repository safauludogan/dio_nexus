import 'package:dio_nexus/src/languages/index.dart';
import 'package:flutter/material.dart';

/// The `NexusLanguage` class is a singleton that manages the loading and retrieval of language resources.
class NexusLanguage {
  /// Private constructor to prevent instantiation.
  NexusLanguage._();

  /// The delegate for loading language resources.
  static const AppLocalizationsDelegate _appLocalizationsDelegate =
      AppLocalizationsDelegate();

  /// The current language.
  static late Languages _nexusLang;

  /// Loads the language resources.
  static Future<void> languageLoad(Locale? locale) async {
    _nexusLang =
        await _appLocalizationsDelegate.load(locale ?? const Locale('en'));
  }

  /// Returns the current language.
  static Languages get getLang => _nexusLang;
}

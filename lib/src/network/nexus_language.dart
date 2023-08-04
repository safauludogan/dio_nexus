import 'package:flutter/material.dart';

import '../languages/abstract/languages.dart';
import '../languages/app_localizations_delegate.dart';

class NexusLanguage {
  NexusLanguage._();
  static late AppLocalizationsDelegate _appLocalizationsDelegate;
  static late Languages _nexusLang;
  static Future<void> languageLoad(Locale? locale) async {
    _appLocalizationsDelegate = const AppLocalizationsDelegate();
    _nexusLang = await _appLocalizationsDelegate.load(locale ?? const Locale('en'));
  }

  static Languages get getLangValue => _nexusLang;
}

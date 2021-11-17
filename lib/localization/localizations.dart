import 'package:flutter/material.dart';

import 'translations.i69n.dart';
import 'translations_uk.i69n.dart';

const _supportedLocales = ['en', 'uk'];

class CustomLocalizations {
  const CustomLocalizations(this.translations);

  final Translations translations;

  static final _translations = <String, Translations Function()>{
    'en': () => const Translations(),
    'uk': () => const Translations_uk(),
  };

  static const LocalizationsDelegate<CustomLocalizations> delegate = _CustomLocalizationsDelegate();
  static final List<Locale> supportedLocales = _supportedLocales.map((e) => Locale(e)).toList();
  static Future<CustomLocalizations> load(Locale locale) => Future.value(CustomLocalizations(_translations[locale.languageCode]!()));
  static Translations of(BuildContext context) => Localizations.of<CustomLocalizations>(context, CustomLocalizations)!.translations;
}

class _CustomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations> {
  const _CustomLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return _supportedLocales.contains(locale.languageCode);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return CustomLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CustomLocalizations> old) {
    return false;
  }
}

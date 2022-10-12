import 'package:flutter/material.dart';
import 'package:save_the_place/localization/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const String _key_selected_lang = 'selected_lang';

  static Locale? selectedLang;

  static Future<void> init() async {
    final lc = await getSelectedLanguageCode();
    selectedLang = _getLocaleByLangCode(lc);
  }

  static Future<String?> getSelectedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_key_selected_lang)) {
      return null;
    }
    return prefs.getString(_key_selected_lang);
  }

  static Future<void> setSelectedLanguageCode(String lc) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key_selected_lang, lc);
    selectedLang = _getLocaleByLangCode(lc);
  }

  static Locale? _getLocaleByLangCode(String? lc) {
    return lc == null ? null : CustomLocalizations.supportedLocales.firstWhere((element) => element.languageCode == lc);
  }
}

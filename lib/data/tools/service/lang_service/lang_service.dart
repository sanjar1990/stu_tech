import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/storage/app/locals/en_EN.dart';
import 'package:stu_tech/data/storage/app/locals/lang_prefs/language_prefs.dart';
import 'package:stu_tech/data/storage/app/locals/ru_RU.dart';
import 'package:stu_tech/data/storage/app/locals/uz_UZ.dart';

class LangService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU': ruRU, // lang/ru_ru.dart
    'uz_UZ': uzUZ, // lang/uz_uz.dart
    'en_EN': enEN// lang/en_en.dart
  };

  static const fallbackLocale = Locale('uz', 'UZ');

  static final items = [
    'Русский',
    'O\'zbekcha',
    'English'
  ];

  static final langs = ['ru', 'uz', 'en'];

  static final List<Locale> locales = [
    const Locale('ru', 'RU'),
    const Locale('uz', 'UZ'),
    const Locale('en', 'EN')
  ];

  static Locale defaultLanguage() {
    var lan = Get.find<LangPrefs>().lang;
    if (lan == "ru") return defLanguage('ru');
    if (lan == "uz") return defLanguage('uz');
    if (lan == "en") return defLanguage('en');
    return defLanguage('uz');
  }

  static Locale defLanguage(String code) {
    var index = langs.indexOf(code);
    return locales[index];
  }

  static void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    if (locale != null) {
      Get.updateLocale(locale);
      Get.find<LangPrefs>().lang = lang;
    }
  }

  static Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.deviceLocale;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleString extends Translations {
  static final locale = Locale("en", "US");
  static final fallBackLocale = Locale("en", "US");
  static final langs = ['English', 'አማርኛ'];
  static final locales = [Locale("en", "US"), Locale("am", "AM")];
  var selectedLang = langs.first.obs;
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    selectedLang.value = lang;
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'HOME':'HOME',
          'CONTACTS':'CONTACTS',
          'events': 'Events',
          'holiday': 'Holiday',
          'birthday': 'Birthday',
          'graduation': 'graduation'
        },
        'am': {
          'CONTACTS':"ስልክ ቁጥሮች",
          'HOME':'ዋና ገፅ',
          'graduation': 'ምረቃ',
          'birthday': 'የልደት በዓል',
          'holiday': 'በዓል',
          'events': 'ክስተቶች',
        }
      };
}

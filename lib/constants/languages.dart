import 'package:flutter/material.dart';

enum Language { traditionalChinese, simplifiedChinese, english }

Map langLocaleMap = {
  Language.english: Locale("en", "US"),
  Language.traditionalChinese: Locale("zh", "TW"),
  Language.simplifiedChinese: Locale("zh", "CN"),
};

Map localeLangStrMap = {
  "en_US": "English",
  "zh_TW": "繁體中文",
  "zh_CN": "简体中文",
};

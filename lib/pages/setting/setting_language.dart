import "package:flutter/material.dart";
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:gitme_reborn/utils.dart';
import 'package:provider/provider.dart';

import 'package:gitme_reborn/constants/languages.dart';
import 'package:gitme_reborn/stores/setting.dart';

class SettingLanguagePage extends StatefulWidget {
  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  SettingModel setting;

  @override
  Widget build(BuildContext context) {
    setting = Provider.of<SettingModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, "setting.language"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          RadioListTile(
            title: Text("English"),
            value: Language.english,
            groupValue: setting.language,
            onChanged: _changeLang,
          ),
          RadioListTile(
            title: Text("繁體中文"),
            value: Language.traditionalChinese,
            groupValue: setting.language,
            onChanged: _changeLang,
          ),
          RadioListTile(
            title: Text("简体中文"),
            value: Language.simplifiedChinese,
            groupValue: setting.language,
            onChanged: _changeLang,
          ),
        ],
      ),
    );
  }

  Future _changeLang(Language changedLang) async {
    setting.changeLanguage(changedLang);
    await FlutterI18n.refresh(context, langLocaleMap[changedLang]);
    showNotify(
      message: FlutterI18n.translate(
        context,
        "setting.switchLangMsg",
        {"lang": langLocaleMap[changedLang].toString()},
      ),
    );
  }
}

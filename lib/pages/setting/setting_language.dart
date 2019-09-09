import "package:flutter/material.dart";

enum Language { traditionalChinese, simplifiedChinese, english }

class SettingLanguagePage extends StatefulWidget {
  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  Language _language = Language.english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language"),
      ),
      body: ListView(
        children: <Widget>[
          RadioListTile(
            title: Text("繁體中文"),
            value: Language.traditionalChinese,
            groupValue: _language,
            onChanged: (Language value) {
              setState(() {
                _language = Language.traditionalChinese;
              });
            },
          ),
          RadioListTile(
            title: Text("简体中文"),
            value: Language.simplifiedChinese,
            groupValue: _language,
            onChanged: (Language value) {
              setState(() {
                _language = Language.simplifiedChinese;
              });
            },
          ),
          RadioListTile(
            title: Text("English"),
            value: Language.english,
            groupValue: _language,
            onChanged: (Language value) {
              setState(() {
                _language = Language.english;
              });
            },
          ),
        ],
      )
    );
  }
}

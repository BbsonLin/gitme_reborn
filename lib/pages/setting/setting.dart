import "package:flutter/material.dart";
import 'package:gitme_reborn/components/setting/theme_option.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: Icon(Icons.palette),
            title: Text("Theme"),
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  ThemeOption(color: Colors.black),
                  ThemeOption(color: Colors.blue),
                  ThemeOption(color: Colors.blueGrey)
                ],
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("English"),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/setting/language");
            },
          ),
        ],
      ),
    );
  }
}

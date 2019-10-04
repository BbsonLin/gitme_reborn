import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "package:gitme_reborn/routes.dart";
import "package:gitme_reborn/pages/home.dart";
import "package:gitme_reborn/pages/login.dart";
import 'package:gitme_reborn/pages/about/about.dart';
import 'package:gitme_reborn/pages/profile/profile.dart';
import 'package:gitme_reborn/pages/setting/setting.dart';
import 'package:gitme_reborn/pages/setting/setting_language.dart';
import 'package:gitme_reborn/pages/trending/trending.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:provider/provider.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (BuildContext context) => AccountModel()),
    ],
    child: GitmeRebornApp(),
  ));
}

class GitmeRebornApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitme Reborn",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      routes: {
        GitmeRebornRoutes.login: (context) => LoginPage(),
        GitmeRebornRoutes.home: (context) => MainPage(),
        GitmeRebornRoutes.profile: (context) => ProfilePage(),
        GitmeRebornRoutes.trending: (context) => TrendingPage(),
        GitmeRebornRoutes.setting: (context) => SettingPage(),
        GitmeRebornRoutes.settingLanguage: (context) => SettingLanguagePage(),
        GitmeRebornRoutes.about: (context) => AboutPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRebornRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}

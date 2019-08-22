import "package:flutter/material.dart";
import "package:gitme_reborn/pages/login.dart";

void main() => runApp(GitmeRebornApp());

class GitmeRebornApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitme Reborn",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}

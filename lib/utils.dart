import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Future<String> searchLanguageColorHexCode(String language) async {
  String githubColors =
      await rootBundle.loadString("assets/data/github-colors.json");
  var githubColorsMap = jsonDecode(githubColors);
  if (language != null) {
    return githubColorsMap[language]["color"];
  } else {
    return null;
  }
}

Future launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

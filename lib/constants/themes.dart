import "package:flutter/material.dart";
import 'package:gitme_reborn/constants/materialColors.dart';

enum AppLightTheme {
  Blue,
  BlueGrey,
  Brown,
  Black,
}

final appLightThemeData = {
  AppLightTheme.Blue: ThemeData(
    primarySwatch: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
  AppLightTheme.BlueGrey: ThemeData(
    primarySwatch: Colors.blueGrey,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
  AppLightTheme.Brown: ThemeData(
    primarySwatch: Colors.brown,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.brown,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
  AppLightTheme.Black: ThemeData(
    primarySwatch: materialBlack,
    buttonTheme: ButtonThemeData(
      buttonColor: materialBlack,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
};

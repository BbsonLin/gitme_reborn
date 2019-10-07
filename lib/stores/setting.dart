import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gitme_reborn/constants/themes.dart';

class SettingModel extends ChangeNotifier {
  ThemeData _themeData = BlueGreyTheme;

  ThemeData get theme => _themeData;

  changeTheme(themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}

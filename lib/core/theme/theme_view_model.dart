import 'package:demo/core/cache/shared_pref.dart';
import 'package:demo/core/theme/dark_theme.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData == darkTheme ? true : false;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    bool deger = getTheme();
    await SharedPref().setTheme(deger);
    notifyListeners();
  }
}

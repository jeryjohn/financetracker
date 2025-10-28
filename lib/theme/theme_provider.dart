import 'package:finance_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  //hive strores data of themeData
  final Box _box = Hive.box("themeData");
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadTheme();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _box.put("isDark", themeData == darkmode);
    notifyListeners();
  }

  void _loadTheme() {
    final isDark = _box.get("isDark", defaultValue: false);
    themeData = isDark ? darkmode : lightmode;
  }

  void toggleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}

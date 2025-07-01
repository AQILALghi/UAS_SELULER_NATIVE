import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;  

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();  
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('themeMode'); 

    if (themeIndex != null && themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[themeIndex];
    } else {
      _themeMode = ThemeMode.system;  
    }
    notifyListeners();  
  }

  void setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return; 

    _themeMode = mode;
    notifyListeners();  

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', _themeMode.index);  
  }
}
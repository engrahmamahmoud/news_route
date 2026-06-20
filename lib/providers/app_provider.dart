import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  static const String _themeKey = 'isDark';
  static const String _langKey = 'languageCode';

  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isArabic => _locale.languageCode == 'ar';

  AppProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool(_themeKey) ?? true;
    final langCode = prefs.getString(_langKey) ?? 'en';

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _locale = Locale(langCode);

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }

  Future<void> changeLanguage(String code) async {
    _locale = Locale(code);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }
}

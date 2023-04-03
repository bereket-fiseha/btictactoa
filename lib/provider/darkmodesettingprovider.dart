import 'package:flutter/cupertino.dart';

class DarkModeSettingProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool isDarkModeEnabled() => _isDarkModeEnabled;

  void toggleDarkMode(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }
}

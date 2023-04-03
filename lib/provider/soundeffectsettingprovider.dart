import 'package:flutter/cupertino.dart';

class SoundEffectSettingProvider extends ChangeNotifier {
  bool _enableSound = false;
  void setEnableSound(value) {
    _enableSound = value;
    notifyListeners();
  }

  bool enableSound() => _enableSound;
}

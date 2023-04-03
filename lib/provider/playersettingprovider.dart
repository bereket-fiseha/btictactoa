import 'package:btictao/model/enum.dart';
import 'package:flutter/material.dart';

import '../games/tictactoa.dart';

class PlayerSettingProvider extends ChangeNotifier {
  String _playerX = "X";
  String _playerO = "O";

  String getPlayerX() => _playerX;

  String getPlayerO() => _playerO;

  String getPlayer(Turn turn) => turn == Turn.N
      ? "N"
      : turn == Turn.X
          ? getPlayerX()
          : getPlayerO();

  void setPlayerX(String name) {
    _playerX = name;
    notifyListeners();
  }

  void setPlayerO(String name) {
    _playerO = name;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

import '../model/enum.dart';

class TicTacStateProvider extends ChangeNotifier {
  var _stateMatrix = [
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N]
  ];

  void setStateMatrix(int row, int col, Turn value) {
    _stateMatrix[row][col] = value;

    notifyListeners();
  }

  List<List<Turn>> getStateMatrix() => _stateMatrix;

  void resetMatrix() {
    _stateMatrix = [
      [Turn.N, Turn.N, Turn.N],
      [Turn.N, Turn.N, Turn.N],
      [Turn.N, Turn.N, Turn.N]
    ];
    notifyListeners();
  }
}

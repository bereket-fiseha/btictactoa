import 'package:btictao/model/enum.dart';

class TicTacController {
  Turn? _checkWinnerInEveryRow(List<List<Turn>> matrix) {
    //check for every row
    //i row
    //j col

//dont check  for value N ,Turn.N
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (j == matrix[i].length - 1) {
          return matrix[i][j];
        } else if (matrix[i][j] == Turn.N || matrix[i][j] != matrix[i][j + 1]) {
          break;
        }
      }
    }
    return null;
  }

  Turn? _checkWinnerInEveryCol(List<List<Turn>> matrix) {
    //check every column
//j col
//i row
//dont check  for value N ,Turn.N
    for (int j = 0; j < matrix.length; j++) {
      for (int i = 0; i < matrix.length; i++) {
        if (i == matrix.length - 1) {
          return matrix[i][j];
        } else if (matrix[i][j] == Turn.N || matrix[i][j] != matrix[i + 1][j]) {
          break;
        }
      }
    }
    return null;
  }

  Turn? _checkWinnerInDiagonal(List<List<Turn>> matrix) {
    //check for diagonal (left to right)
    int j = 0;
    int i = 0;
    while (i == matrix.length - 1 ||
        matrix[i][j] == matrix[i + 1][j + 1] && matrix[i][j] != Turn.N) {
      if (i == matrix.length - 1) {
        return matrix[i][j];
      }
      i++;
      j++;
    }
    //check for diagonal (right to left)
    j = matrix.length - 1;
    i = 0;
    while (i == matrix.length - 1 ||
        matrix[i][j] == matrix[i + 1][j - 1] && matrix[i][j] != Turn.N) {
      if (i == matrix.length - 1) {
        return matrix[i][j];
      }
      i++;
      j--;
    }
    return null;
  }

  Turn? checkWinner(List<List<Turn>> matrix) {
    var winnerByRow = _checkWinnerInEveryRow(matrix);
    var winnerByCol = _checkWinnerInEveryCol(matrix);
    var winnerByDiagonal = _checkWinnerInDiagonal(matrix);

    if (winnerByRow != null) {
      return winnerByRow;
    } else if (winnerByCol != null) {
      return winnerByCol;
    } else if (winnerByDiagonal != null) {
      return winnerByDiagonal;
    }

    return null;
  }
}

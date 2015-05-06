library gol.world;

import 'dart:async';
import 'cell.dart';

class World {
  static List<int> _rows, _cols;

  final int NEIGHBOURS_IN_PREMIUM_NEIGHBOURHOOD = 3;
  final int NEIGHBOURS_IN_OPTIMUM_NEIGHBOURHOOD = 4;

  List<List<Cell>> _currentState, _newState;
  int limit;

  static World create(int dimensions) {
    var newWorld = new World();
    newWorld.limit = dimensions;
    _rows = new List<int>.generate(dimensions, (int index) => index);
    _cols = new List<int>.generate(dimensions, (int index) => index);
    return newWorld;
  }

  World giveBirthTo(List<List<Cell>> someShape) {
    _currentState = someShape;
    return this;
  }

  World goForthAndMultiply() {
    new Timer.periodic(new Duration(milliseconds: 1000), (timer) => _evolve());
    return this;
  }

  World _evolve() {
    _newState = _createBlankState();

    _rows.forEach((row) {
      _cols.forEach((col) {
        int liveNeighbours = _getLiveNeighboursOf(row, col);

        _newState[row][col] = _isNiceNeighbourhood(liveNeighbours)? new Cell.live()
            : _isMovingOutImpossible(liveNeighbours)? new Cell(_currentCellState(row, col)) : new Cell.die();
      });
    });

    _switchStates();
    return this;
  }

  int _getLiveNeighboursOf(int row, int col) {
    int count = (_currentState[row][col].alive) ? 1 : 0;

    if (col > 0) {
      if (row > 0) {
        count += (_currentState[row - 1][col - 1].alive) ? 1 : 0; // left up
      }

      count += (_currentState[row][col - 1].alive) ? 1 : 0; // left

      if (row < (limit - 1)) {
        count += (_currentState[row + 1][col - 1].alive) ? 1 : 0; // left down
      }
    }

    if (row > 0) {
      count += (_currentState[row - 1][col].alive) ? 1 : 0; // up
    }

    if (row < (limit - 1)) {
      count += (_currentState[row + 1][col].alive) ? 1 : 0; // down
    }

    if (col < (limit - 1)) {
      if (row > 0) {
        count += (_currentState[row - 1][col + 1].alive) ? 1 : 0; //right up
      }

      count += (_currentState[row][col + 1].alive) ? 1 : 0; //right

      if (row < (limit - 1)) {
        count += (_currentState[row + 1][col + 1].alive) ? 1 : 0; // right down
      }
    }

    return count;
  }

  bool _isNiceNeighbourhood(int liveNeighbours) {
    return liveNeighbours == NEIGHBOURS_IN_PREMIUM_NEIGHBOURHOOD;
  }

  bool _isMovingOutImpossible(int liveNeighbours) {
    return liveNeighbours == NEIGHBOURS_IN_OPTIMUM_NEIGHBOURHOOD;
  }

  List<List<Cell>> _createBlankState() {
    List<List<Cell>> blankState = new List<List<Cell>>();
    for (int row = 0; row < limit; row++) {
      List<Cell> list = new List<Cell>();
      for (int col = 0; col < limit; col++) {
        list.add(new Cell.die());
      }
      blankState.add(list);
    }
    return blankState;
  }

  void _switchStates() {
    _currentState = _newState;
    _newState = null;
  }

  bool _currentCellState(int row, int col) => _currentState[row][col].alive;

  Cell cellAt(int row, int col) {
    return _currentState[row][col];
  }
}

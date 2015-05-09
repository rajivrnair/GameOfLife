library gol.world;

import 'dart:async';
import 'cell.dart';

class World {
  static List<int> _rows, _cols;

  final int NUMBER_OF_NEIGHBOURS_FOR_NEW_LIFE = 3;
  final int NUMBER_OF_NEIGHBOURS_FOR_CURRENT_STATE = 4;
  final int STATE_DEAD = 0;
  final int STATE_ALIVE = 1;

  List<List<Cell>> _currentState, _newState;
  int size;
  int generation;

  static World create() {
    return new World();
  }

  World withLife(List<List<Cell>> initialState) {
    this.size = initialState.length;
    this.generation = 0;
    _currentState = initialState;

    _rows = new List<int>.generate(size, (int index) => index);
    _cols = new List<int>.generate(size, (int index) => index);

    return this;
  }

  World evolve() {
    new Timer.periodic(new Duration(milliseconds: 500), (timer) => _nextGeneration());
    return this;
  }

  World _nextGeneration() {
    _newState = _createBlankState();

    _rows.forEach((row) {
      _cols.forEach((col) {
        int liveNeighbours = _getLiveNeighboursOf(row, col);

        _newState[row][col] = _canCellComeAlive(liveNeighbours)? new Cell.live()
            : _canCellContinueAsIs(liveNeighbours)? new Cell(_currentCellState(row, col)) : new Cell.die();
      });
    });

    _switchStates();
    this.generation++;

    return this;
  }

  int _getLiveNeighboursOf(int row, int col) {
    int count = _amIDeadOrAlive(row, col);

    count += _isTopLeftNeighbourAlive(row, col);
    count += _isLeftNeighbourAlive(row, col);
    count += _isBottomLeftNeighbourAlive(row, col);

    count += _isNeighbourAboveAlive(row, col);
    count += _isNeighbourBelowAlive(row, col);

    count += _isTopRightNeighbourAlive(row, col);
    count += _isRightNeighbourAlive(row, col);
    count += _isBottomRightNeighbourAlive(row, col);

    return count;
  }

  int _isBottomRightNeighbourAlive(row, col) =>
      (_notRightMostCol(col) && _notBottomRow(row)) ? _isAlive(_rowBelow(row), _colRight(col)) : STATE_DEAD;

  int _isRightNeighbourAlive(row, col) => _notRightMostCol(col) ? _isAlive(row, _colRight(col)) : STATE_DEAD;

  int _isTopRightNeighbourAlive(int row, int col) =>
      (_notRightMostCol(col) && _notTopRow(row)) ? _isAlive(_rowAbove(row), _colRight(col)) : STATE_DEAD;

  int _isTopLeftNeighbourAlive(int row, int col) =>
      (_notLeftMostCol(col) && _notTopRow(row)) ? _isAlive(_rowAbove(row),_colLeft(col)) : STATE_DEAD;

  int _isLeftNeighbourAlive(int row, int col) => _notLeftMostCol(col) ? _isAlive(row,_colLeft(col)) : STATE_DEAD;

  int _isBottomLeftNeighbourAlive(int row, int col) =>
      (_notLeftMostCol(col) && _notBottomRow(row)) ? _isAlive(_rowBelow(row),_colLeft(col)) : STATE_DEAD;

  int _isNeighbourAboveAlive(int row, int col) => _notTopRow(row) ? _isAlive(_rowAbove(row), col) : STATE_DEAD;

  int _isNeighbourBelowAlive(int row, int col) => _notBottomRow(row) ? _isAlive(_rowBelow(row), col) : STATE_DEAD;

  int _amIDeadOrAlive(int row, int col) => _isAlive(row, col);

  int _isAlive(int row, int col) => (_currentState[row][col].alive) ? STATE_ALIVE : STATE_DEAD;


  bool _notTopRow(int row) => row > 0;
  bool _notBottomRow(int row) => row < (size - 1);
  bool _notLeftMostCol(int col) => col > 0;
  bool _notRightMostCol(int col) => col < (size - 1);


  int _rowAbove(int row) => row - 1;
  int _rowBelow(int row) => row + 1;
  int _colLeft(int col) => col - 1;
  int _colRight(int col) => col + 1;


  bool _canCellComeAlive(int liveNeighbours) {
    return liveNeighbours == NUMBER_OF_NEIGHBOURS_FOR_NEW_LIFE;
  }

  bool _canCellContinueAsIs(int liveNeighbours) {
    return liveNeighbours == NUMBER_OF_NEIGHBOURS_FOR_CURRENT_STATE;
  }

  List<List<Cell>> _createBlankState() {
    List<List<Cell>> blankState = new List<List<Cell>>();

    _rows.forEach((row) {
      List<Cell> list = new List<Cell>();
      blankState.add(list);

      _cols.forEach((col) {
        list.add(new Cell.die());
      });
    });

    return blankState;
  }

  void _switchStates() {
    _currentState = _newState;
    _newState = null;
  }

  bool _currentCellState(int row, int col) => _currentState[row][col].alive;

  Cell _cellAt(int row, int col) {
    return _currentState[row][col];
  }

  bool isCellAliveAt(int row, int col) {
    return _cellAt(row, col).alive;
  }
}

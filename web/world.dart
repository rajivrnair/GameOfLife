library gol.world;
import 'cell.dart';

class World {

  List<List<Cell>> currentState;
  List<List<Cell>> newState;
  int limit;

  static World create() {
    return new World();
  }

  World withLimits(int limit) {
    this.limit = limit;
    return this;
  }

  World giveBirthTo(List<List<Cell>> cells) {
    currentState = cells;
    return this;
  }

//  void printState(List<List<Cell>> state) {
//    for(int row = 0; row<limit; row++) {
//      for(int col = 0;col<limit; col++) {
//        bool cellState = state[row][col].alive;
//        print('cell[$row][$col]: $cellState');
//      }
//    }
//  }

  World evolve() {
    newState = createBlankState();

    for(int row = 0; row < limit; row++) {
      for(int col = 0; col < limit; col++) {
        int liveNeighbours = getLiveNeighboursOf(row, col);

        if (liveNeighbours == 3) {
          newState[row][col] = new Cell.live();
        } else if (liveNeighbours == 4) {
          newState[row][col] = new Cell(currentState[row][col].alive);
        } else {
          newState[row][col] = new Cell.die();
        }
      }
    }
    switchState();

    return this;
  }

  List<List<Cell>> createBlankState() {
    List<List<Cell>> blankState = new List<List<Cell>>();
    for(int row = 0; row<limit; row++) {
      List<Cell> list = new List<Cell>();
      for(int col = 0;col<limit; col++) {
        list.add(new Cell.die());
      }
      blankState.add(list);
    }
    return blankState;
  }

  int getLiveNeighboursOf(int row, int col) {
    int count = (currentState[row][col].alive) ? 1 : 0;

    if(col > 0) {
      if(row > 0) {
        count += (currentState[row-1][col-1].alive) ? 1 : 0; // left up
      }

      count += (currentState[row][col-1].alive) ? 1 : 0; // left

      if(row < (limit-1)) {
        count += (currentState[row+1][col-1].alive) ? 1 : 0; // left down
      }
    }

    if(row > 0) {
      count += (currentState[row-1][col].alive) ? 1 : 0; // up
    }

    if(row < (limit-1)) {
      count += (currentState[row+1][col].alive) ? 1 : 0; // down
    }

    if(col < (limit-1)) {
      if(row > 0) {
        count += (currentState[row-1][col+1].alive) ? 1 : 0; //right up
      }

      count += (currentState[row][col+1].alive) ? 1 : 0; //right

      if(row < (limit-1)) {
        count += (currentState[row+1][col+1].alive) ? 1 : 0; // right down
      }
    }

    return count;
  }

  void switchState() {
    currentState = newState;
    newState = null;
  }

  Cell getCell(int row, int col) {
    return currentState[row][col];
  }
}

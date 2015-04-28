library gol.lifeForms;

import 'cell.dart';

class LifeForms {

  static bool ALIVE = true;
  static bool DEAD = !ALIVE;

  // Still Life
  static List<List<Cell>> beeHive() {
    return [
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)]
      ];
  }

  static List<List<Cell>> loaf() {
    return [
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)]
      ];
  }

  // Oscillators
  static List<List<Cell>> blinker() {
    return [
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)]
      ];
  }

  static List<List<Cell>> toad() {
    return [
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)]
      ];
  }

  // Random-awesomeness!
  static List<List<Cell>> rPentomino() {
    return [
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(ALIVE), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(ALIVE), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)],
      [new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD), new Cell(DEAD)]
      ];
  }
}
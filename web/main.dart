import 'dart:html';
import 'dart:async';

import 'world.dart';
import 'cell.dart';
import 'lifeForms.dart' show LifeForms;

final int DIMENSIONS = 6;
final String LINE_COLOUR = "#786969";
final String LIVING_CELL_COLOUR = "#6DC066";
final String LIVING_CELL_BORDER = "#8D6590";

CanvasRenderingContext2D ctx;
CanvasElement canvas;
int cellSize;
List<int> rows, cols;

/**
  * Conway's Game of Life rules:
  * 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  * 2. Any live cell with two or three live neighbours lives on to the next generation.
  * 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  * 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  */
void main() {

  World world = World.create(DIMENSIONS)
                  .giveBirthTo(LifeForms.rPentomino())
                  .goForthAndMultiply();

  paint(world);
}


void paint(World world) {
  setTitle('Conway\'s Game Of Life');
  initCanvas(world);

  new Timer.periodic(new Duration(milliseconds: 500), (timer) => redraw(world));
}

void redraw(World world) {
  clearCanvas();
  drawBackground(world);
  setColouringStyles();

  // Is this readable?
  rows.forEach((row) {
    cols.where((col) => isAlive(world.cellAt(row, col)))
        .forEach((col) => colourCell(world.cellAt(row, col), row, col));
  });

  // Or are double for-loops more intuitive for matrix operations?
//  for (int row = 0; row < world.limit; row++) {
//    for (int col = 0; col < world.limit; col++) {
//      if(isAlive(world.cellAt(row, col))) {
//        colourCell(world.cellAt(row, col), row, col);
//      }
//    }
//  }
}

bool isAlive(Cell cell) {
  return cell.alive == true;
}

void setColouringStyles() {
  ctx.strokeStyle = LIVING_CELL_BORDER;
  ctx.fillStyle = LIVING_CELL_COLOUR;
}

void clearCanvas() {
  canvas.width = canvas.width;
}

void colourCell(Cell cell, int row, int col) {
  ctx.fillRect(row * cellSize, col * cellSize, cellSize, cellSize);
  ctx.strokeRect(row * cellSize, col * cellSize, cellSize, cellSize);
}

void drawBackground(World world) {
  ctx.strokeStyle = LINE_COLOUR;
  ctx.beginPath();

  for (int index = 0; index < world.limit; index++) {

    // columns
    ctx.moveTo(cellSize * index, 0);
    ctx.lineTo(cellSize * index, 500);

    // rows
    ctx.moveTo(0, cellSize * index);
    ctx.lineTo(500, cellSize * index);
  }
  ctx.stroke();
}

void setTitle(String title) {
  querySelector('#title').text = title;
}

void initCanvas(World world) {
  canvas = querySelector('#canvas');
  ctx = canvas.getContext('2d');
  cellSize = 500 ~/ world.limit;

  rows = new List<int>.generate(world.limit, (int index) => index);
  cols = new List<int>.generate(world.limit, (int index) => index);
}

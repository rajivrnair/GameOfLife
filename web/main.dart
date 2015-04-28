import 'dart:html';
import 'dart:async';

import 'world.dart';
import 'lifeForms.dart' show LifeForms;

/**
  * Conway's Game of Life rules:
  * 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  * 2. Any live cell with two or three live neighbours lives on to the next generation.
  * 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  * 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  */
final String LINE_COLOUR = "#786969";
final String LIVING_CELL_COLOUR = "#6DC066";
final String LIVING_CELL_BORDER = "#8D6590";

CanvasRenderingContext2D ctx;
CanvasElement canvas;
int cellSize;

void main() {
  setTitle('Conway\'s Game Of Life');

  World world = World.create().withLimits(6).giveBirthTo(LifeForms.rPentomino());

  initCanvas(world);

  goForthAndMultiply(world);
}

void goForthAndMultiply(World world) {
  new Timer.periodic(new Duration(milliseconds: 1000), (timer) => world.evolve());
  new Timer.periodic(new Duration(milliseconds: 500), (timer) => draw(world));
}

void initCanvas(World world) {
  canvas = querySelector('#canvas');
  ctx = canvas.getContext('2d');
  cellSize = 500 ~/ world.limit;
}

void draw(World world) {
  canvas.width = canvas.width; // clear canvas
  drawBackground(world);
  ctx.strokeStyle = LIVING_CELL_BORDER;
  ctx.fillStyle = LIVING_CELL_COLOUR;
  for (int row = 0; row < world.limit; row++) {
    for (int col = 0; col < world.limit; col++) {
      if (world.getCell(row, col).alive) {
        ctx.fillRect(row * cellSize, col * cellSize, cellSize, cellSize);
        ctx.strokeRect(row * cellSize, col * cellSize, cellSize, cellSize);
      }
    }
  }
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

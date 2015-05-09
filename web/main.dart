import 'world.dart';
import 'canvas.dart';
import 'lifeForms.dart' show LifeForms;

/**
  * Conway's Game of Life rules:
  * 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  * 2. Any live cell with two or three live neighbours lives on to the next generation.
  * 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  * 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  */
void main() {

  World world = World.create()
                  .withLife(LifeForms.rPentomino())
                  .evolve();

  Canvas.paint(world);
}
library gol.cell;

class Cell {
  bool alive;

  Cell(this.alive);
  Cell.live() : this(true);
  Cell.die() : this(false);
}
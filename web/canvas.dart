import 'dart:html';
import 'dart:async';
import 'world.dart';

final String LINE_COLOUR = "#786969";
final String LIVING_CELL_COLOUR = "#6DC066";
final String LIVING_CELL_BORDER = "#8D6590";

CanvasRenderingContext2D _ctx;
CanvasElement _canvas;
int _cellSize;
List<int> _rows, _cols;

class Canvas {

  static void paint(World world) {
    _initCanvas(world);
    _every250ms(_redraw, world);
  }

  static void _every250ms(Function toBeExecuted, Object withParam) {
    new Timer.periodic(new Duration(milliseconds: 250), (timer) => toBeExecuted(withParam));
  }

  static var _redraw = (World world) {
    _setTitle('Conway\'s Game Of Life. Generation: ${world.generation}');
    _clearCanvas();
    _drawBackground(world);
    _setColouringStyles();

    _rows.forEach((row) {
      _cols.where((col) => _isCellAlive(world, row, col))
          .forEach((col) => _colourCell(row, col));
    });
  };

  static bool _isCellAlive(World world, int row, int col) {
    return world.isCellAliveAt(row, col) == true;
  }

  static void _setColouringStyles() {
    _ctx.strokeStyle = LIVING_CELL_BORDER;
    _ctx.fillStyle = LIVING_CELL_COLOUR;
  }

  static void _clearCanvas() {
    _canvas.width = _canvas.width;
  }

  static void _colourCell(int row, int col) {
    _ctx.fillRect(row * _cellSize, col * _cellSize, _cellSize, _cellSize);
    _ctx.strokeRect(row * _cellSize, col * _cellSize, _cellSize, _cellSize);
  }

  static void _drawBackground(World world) {
    _ctx.strokeStyle = LINE_COLOUR;
    _ctx.beginPath();

    for (int index = 0; index < world.size; index++) {

      // columns
      _ctx.moveTo(_cellSize * index, 0);
      _ctx.lineTo(_cellSize * index, 500);

      // rows
      _ctx.moveTo(0, _cellSize * index);
      _ctx.lineTo(500, _cellSize * index);
    }
    _ctx.stroke();
  }

  static void _setTitle(String title) {
    querySelector('#title').text = title;
  }

  static void _initCanvas(World world) {
    _canvas = querySelector('#canvas');
    _ctx = _canvas.getContext('2d');
    _cellSize = 500 ~/ world.size;

    _rows = new List<int>.generate(world.size, (int index) => index);
    _cols = new List<int>.generate(world.size, (int index) => index);
  }
}
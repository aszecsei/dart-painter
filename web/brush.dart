import 'dart:math';
import 'dart:html';
import 'package:color/color.dart';

class _BrushStroke {
  final Point position;
  final Color color;

  _BrushStroke(this.position, this.color);
}

class Brush {
  List<_BrushStroke> _strokes;

  Brush() {
    _strokes = new List();
  }

  void addStroke(Point pos, Color col) {
    _strokes.add(new _BrushStroke(pos, col));
  }

  void draw(CanvasRenderingContext2D context) {
    _strokes.forEach((_BrushStroke bs) {
      RgbColor rgb = bs.color.toRgbColor();
      context.setFillColorRgb(rgb.r, rgb.g, rgb.b);
      context.beginPath();
      context.arc(bs.position.x, bs.position.y, 10, 0, 2*PI);
      context.fill();
    });
  }
}
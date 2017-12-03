import 'dart:math';
import 'dart:html';
import 'package:color/color.dart';
import 'input.dart';

class _BrushStroke {
  final Point position;
  final Color color;

  _BrushStroke(this.position, this.color);
}

class Brush {
  List<_BrushStroke> _strokes;
  Color color;
  Point _lastPoint = null;
  Mouse _mouse = new Mouse();

  Brush(this.color) {
    _strokes = new List();
  }

  void _addStroke(Point pos, Color col) {
    _strokes.add(new _BrushStroke(pos, col));
  }

  void startDrawing() {
    Point pos = _mouse.getPosition();
    if(_lastPoint == null) {
      _addStroke(pos, color);
    } else {
      num distance = pos.distanceTo(_lastPoint);
      if(distance > 2) {
        for(num i =0; i < distance; i+=2) {
          Point ray = pos - _lastPoint;
          ray = ray * (1 / ray.magnitude);
          _addStroke(_lastPoint + ray * i, color);
        }
      }
    }
    _lastPoint = pos;
  }

  void stopDrawing() {
    _lastPoint = null;
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
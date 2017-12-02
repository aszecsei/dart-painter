import 'dart:html';
import 'input.dart';
import 'brush.dart';
import 'package:color/color.dart';

import 'package:logging/logging.dart';

class Canvas {
  final Logger _log = new Logger('Canvas');

  CanvasElement htmlCanvas;
  CanvasRenderingContext2D context;

  Keyboard keyboard = new Keyboard();
  Mouse mouse = new Mouse();
  Brush brush = new Brush();

  num _lastTimeStamp = 0;
  Point _lastPoint = null;

  static const num GAME_SPEED = 1000/60;

  Canvas(this.htmlCanvas, this.context);

  void clear() {
    context.clearRect(0, 0, htmlCanvas.width, htmlCanvas.height);
  }
  
  void _checkInput() {
    if (mouse.isClicked(0)) {
      Point pos = mouse.getPosition();
      if(_lastPoint == null) {
        brush.addStroke(pos, new Color.rgb(0, 0, 0));
      } else {
        num distance = pos.distanceTo(_lastPoint);
        if(distance > 2) {
          for(num i =0; i < distance; i+=2) {
            Point ray = pos - _lastPoint;
            ray = ray * (1 / ray.magnitude);
            brush.addStroke(_lastPoint + ray * i, new Color.rgb(0, 0, 0));
          }
        }
      }
      _lastPoint = pos;
    } else {
      _lastPoint = null;
    }
  }

  void update(num delta) {
    final num diff = delta - _lastTimeStamp;

    if (diff >= GAME_SPEED) {
      _lastTimeStamp = delta;
      clear();
    }
    
    _checkInput();
    brush.draw(context);
    window.animationFrame.then(update);
  }

  void run() {
    window.animationFrame.then(update);
  }
}
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

  Color color1 = new Color.rgb(0, 0, 0);
  Color color2 = new Color.rgb(255, 255, 255);
  Brush brush;

  bool _selectedColorOne = true;

  num _lastTimeStamp = 0;


  static const num GAME_SPEED = 1000/60;

  Canvas(this.htmlCanvas, this.context) {
    brush = new Brush(color1);
  }

  void clear() {
    context.clearRect(0, 0, htmlCanvas.width, htmlCanvas.height);
  }
  
  void _checkInput() {
    if (keyboard.isKeyPressed(KeyCode.E)) {
      _log.fine("Switching brushes...");
      _selectedColorOne = !_selectedColorOne;
      brush.color = _selectedColorOne ? color1 : color2;
    }

    if (mouse.isClicked(0)) {
      brush.startDrawing();
    } else {
      brush.stopDrawing();
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

    keyboard.flush();
    window.animationFrame.then(update);
  }

  void run() {
    window.animationFrame.then(update);
  }
}
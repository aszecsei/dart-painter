import 'dart:html';
import 'canvas.dart';
import 'package:logging/logging.dart';

CanvasElement htmlCanvas;
CanvasRenderingContext2D context;

void initializeCanvas() {
  window.addEventListener('resize', resizeCanvas, false);
  resizeCanvas();
}

void resizeCanvas([Event e]) {
  htmlCanvas.width = window.innerWidth;
  htmlCanvas.height = window.innerHeight;
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  htmlCanvas = querySelector("#canvas");
  context = htmlCanvas.getContext('2d');
  initializeCanvas();
  new Canvas(htmlCanvas, context)..run();
}

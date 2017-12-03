import 'dart:html';
import 'dart:collection';
import 'dart:math';

class Keyboard {
  HashMap<int, double> _oldKeys = new HashMap<int, double>();
  HashMap<int, double> _keys = new HashMap<int, double>();

  Keyboard() {
    window.onKeyDown.listen((KeyboardEvent event) {
      if (!_keys.containsKey(event.keyCode)) {
        _keys[event.keyCode] = event.timeStamp;
      }
      event.preventDefault();
    });
    window.onKeyUp.listen((KeyboardEvent event) {
      _keys.remove(event.keyCode);
      event.preventDefault();
    });
  }

  bool isKeyDown(int keyCode) => _keys.containsKey(keyCode);
  bool isKeyPressed(int keyCode) => _keys.containsKey(keyCode) && !_oldKeys.containsKey(keyCode);
  bool isKeyUp(int keyCode) => !_keys.containsKey(keyCode);
  bool isKeyReleased(int keyCode) => !_keys.containsKey(keyCode) && _oldKeys.containsKey(keyCode);

  void flush() {
    _oldKeys.clear();
    _oldKeys.addAll(_keys);
    _keys.clear();
  }
}

class Mouse {
  HashMap<int, double> _buttons = new HashMap<int, double>();
  Point _position = new Point(0, 0);

  Mouse() {
    window.onMouseDown.listen((MouseEvent event) {
      if (!_buttons.containsKey(event.button)) {
        _buttons[event.button] = event.timeStamp;
      }
      event.preventDefault();
    });
    window.onMouseUp.listen((MouseEvent event) {
      _buttons.remove(event.button);
    });
    window.onMouseMove.listen((MouseEvent event) {
      _position = event.offset;
    });
  }

  bool isClicked(int button) => _buttons.containsKey(button);
  Point getPosition() => _position;
}
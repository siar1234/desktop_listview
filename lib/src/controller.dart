import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DesktopListviewController extends ChangeNotifier {
  final Set<String> selectedItems = {};
  bool ctrlPressed = false;
  bool shiftPressed = false;
  final focusNode = FocusNode();

  void addItem(String id) {
    selectedItems.add(id);
    notifyListeners();
  }
  void removeItem(String id) {
    selectedItems.remove(id);
    notifyListeners();
  }

  void startSelection() {

  }

  void endSelection() {
    selectedItems.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }
  
  void handleKeyEvent(KeyEvent event) {
    if (event is KeyUpEvent) {
      ctrlPressed = false;
      shiftPressed = false;
      return;
    }
    if (event.physicalKey == PhysicalKeyboardKey.metaLeft ||
        event.physicalKey == PhysicalKeyboardKey.controlLeft ||
        event.physicalKey == PhysicalKeyboardKey.controlRight) {
      ctrlPressed = true;
      shiftPressed = false;
    }

    if (event.physicalKey == PhysicalKeyboardKey.shiftLeft || event.physicalKey == PhysicalKeyboardKey.shiftRight) {
      ctrlPressed = false;
      shiftPressed = true;
    }

    if (ctrlPressed && event.physicalKey == PhysicalKeyboardKey.keyA) {
      // selectedItems.addAll(idList);
    }
  }
  
  void handleItemPressed(void Function(int index)? onItemPressed) {

  }
}
import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle getDeleteButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
      Colors.red,
    ));
  }
}

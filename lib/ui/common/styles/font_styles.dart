import 'package:flutter/material.dart';

class FontStyles {
  static TextStyle getHeaderTextStyle() {
    return TextStyle(
      fontSize: 18,
      color: Colors.deepPurple[900],
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle getSmallTextStyle() {
    return TextStyle(
      fontSize: 12,
      color: Colors.grey[500],
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle getMainTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.grey[900],
      fontWeight: FontWeight.normal,
    );
  }
}

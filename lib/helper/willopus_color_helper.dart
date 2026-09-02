import 'package:flutter/material.dart';

class WillOpusColorHelper {
  /// Convert a string hex into a Flutter color value.
  /// This expects a 8 digit value from the color picker, or a proper default color!
  // TODO: error handling her? improper format should be handled somewher along the way!
  static Color colorFromHex(String hex) {
    return Color(int.parse('0x' + hex));
  }
}

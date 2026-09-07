import 'package:flutter/material.dart';

class WillOpusColorHelper {
  /// Convert a string hex code into a Flutter color value.
  /// IN: An 8 digit RGBA hex code that can be parsed into a Flutter color.
  /// This expects a 8 digit 0-9,A-F hex value string from the color picker, or a proper color hex!
  // TODO: error handling her? improper format should be handled somewher along the way!
  static Color colorFromHex(String hex) {
    return Color(int.parse('0x' + hex));
  }
}

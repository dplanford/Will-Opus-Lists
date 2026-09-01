import 'package:flutter/material.dart';

class WillOpusColorHelper {
  static Color colorFromHex(String hex) {
    return Color(int.parse('0x' + hex));
  }
}

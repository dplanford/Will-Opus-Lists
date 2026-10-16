import 'package:flutter/material.dart';

// TODO: Does this need to be a WillOpus named class? So far it handles generic stuff.
// It could be just "ColorPickerHelper (color_picker_helper.dart)"....
// Keeping the name for now... this could turn into a more locally customized dialog....

/// Helper functions for the color picker dialog.
///
class WillOpusColorHelper {
  /// Convert a string hex code into a Flutter color value.
  /// IN: An 8 digit RGBA hex code that can be parsed into a Flutter color.
  /// This expects a 8 digit 0-9,A-F hex value string from the color picker, or a proper color hex!

  // TODO: error handling here? Improper format should be handled somewhere along the way!
  // This will currently pass on a format exception on parse error.

  // TODO: is it possible to customize some of this into my color picker dialog?

  /// Convert a 6 digit String hex code into a Flutter Color.
  /// No error handling is provided... the input must parse as 6 hex chars (0-9, aA-fF).
  /// If not, this will throw a Int parse exception.
  static Color colorFromHex(String hex) {
    return Color(int.parse('0x$hex'));
  }
}

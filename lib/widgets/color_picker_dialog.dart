import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog {
  /// A modal color picker dialog.
  static Future<String?> pickColor({
    required BuildContext context,
    required Color initialColor,
  }) async {
    bool cancelled = false;
    final textController = TextEditingController(text: initialColor.toARGB32().toRadixString(16));

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: Column(
            children: [
              ColorPicker(
                pickerColor: initialColor,
                onColorChanged: (color) {},
                colorPickerWidth: 300,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: true,
                displayThumbColor: true,
                paletteType: PaletteType.hsvWithHue,
                labelTypes: const [],
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
                hexInputController: textController,
                portraitOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  maxLength: 9,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                cancelled = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
    if (cancelled) return null;
    return textController.text;
  }
}

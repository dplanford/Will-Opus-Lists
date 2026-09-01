import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/helper/willopus_color_helper.dart';
import 'package:willopuslists/widgets/adaptive_alert_dialog.dart';
import 'package:willopuslists/widgets/color_picker_dialog.dart';
import 'package:willopuslists/constants.dart';

class WillOpusListCreateDialog {
  static Future<WillOpusList?> show(BuildContext context) async {
    bool cancelled = false;
    String listColorHex = kDefaultListColorHex;
    Color displayColor = WillOpusColorHelper.colorFromHex(listColorHex);
    TextEditingController titleController = TextEditingController();
    var titleField = TextField(
      controller: titleController,
      decoration: InputDecoration(hintText: 'Select List Title', fillColor: Colors.white),
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AdaptiveAlertDialog(
          title: Container(
            color: displayColor,
            child: Column(
              children: [
                Material(
                  type: MaterialType.card,
                  child: titleField,
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    String? newColorHex = await ColorPickerDialog.pickColor(
                      context: context,
                      initialColor: Colors.white,
                    );
                    if (newColorHex != null && newColorHex.isNotEmpty) {
                      listColorHex = newColorHex;
                      displayColor = WillOpusColorHelper.colorFromHex(listColorHex);
                    }
                  },
                  child: Text('Select List Color'),
                ),
              ],
            ),
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
              child: const Text('Add New List'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (cancelled) return null;
    return WillOpusList(
      title: titleField.controller!.text,
      hexColor: listColorHex,
    );
  }
}

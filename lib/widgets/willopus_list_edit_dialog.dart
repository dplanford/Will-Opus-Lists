import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/helper/willopus_color_helper.dart';
import 'package:willopuslists/widgets/adaptive_alert_dialog.dart';
import 'package:willopuslists/widgets/color_picker_dialog.dart';
import 'package:willopuslists/constants.dart';

// Auto-generated
import 'package:willopuslists/l10n/app_localizations.dart';

/// A popup dialog for creating a new list of items.
/// Returns a WillOpusList filled with a title and background color,
/// plus a null id & empty list of items.
///
/// If an existing list object is input, then the dialog edits it.
///
/// TODO: Add description text field/text area input/editing!
///   - WillOpusList.desc, newly added!
///
class WillOpusListEditDialog {
  static Future<WillOpusList?> show(
    BuildContext context, {
    WillOpusList? list,
  }) async {
    bool cancelled = false;

    String listColorHex = list != null ? list.hexColor : kDefaultListColorHex;
    Color displayColor = WillOpusColorHelper.colorFromHex(listColorHex);

    String addOrEditString = '';
    if (list == null) {
      addOrEditString = AppLocalizations.of(context)!.editListAdd;
    } else {
      addOrEditString = AppLocalizations.of(context)!.editListUpdate;
    }

    TextEditingController titleController = TextEditingController();
    if (list != null) titleController.text = list.title;
    TextField titleField = TextField(
      controller: titleController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.createListSelectTitle,
        fillColor: Colors.white,
      ),
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
                  child: Text(AppLocalizations.of(context)!.createListSelectColor),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                cancelled = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(addOrEditString),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // Cancelled, return nothing.
    if (cancelled) return null;
    // Editing existing list, update it.
    if (list != null) {
      list.title = titleField.controller!.text;
      list.hexColor = listColorHex;
      return list;
    }
    // Return a new list.
    return WillOpusList(
      title: titleField.controller!.text,
      hexColor: listColorHex,
    );
  }
}

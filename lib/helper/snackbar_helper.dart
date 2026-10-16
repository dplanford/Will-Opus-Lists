import 'package:flutter/material.dart';

/// Helper for quick toast/snackbar notifications.
///
class SnackbarHelper {
  /// Show a text toast at the bottom of the current display context.
  static void showSnackBar(BuildContext context, String txt) {
    var snackBar = SnackBar(
      content: Text(txt),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

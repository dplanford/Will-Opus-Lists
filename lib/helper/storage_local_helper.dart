import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Handle Local Storage of app data.
class StorageLocalHelper {
  static late SharedPreferences shared;

  static Future<void> init() async {
    shared = await SharedPreferences.getInstance();
  }

  /// Load an generic object from it's id.
  /// check if the return can be JSON decoded into a Flutter Map<String, dynamic>.
  /// return the map, or null on any failure.
  static Future<Map<String, dynamic>?> getMapFromJson(String id) async {
    String? data = await shared.getString(id);
    if (data == null) return null;
    var item = json.decode(data);
    if (item is Map<String, dynamic>) {
      return item;
    }
    return null;
  }
}

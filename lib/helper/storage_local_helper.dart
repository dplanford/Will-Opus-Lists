// ignore_for_file: unintended_html_in_doc_comment

import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// Handle Local Storage of app data.
/// This matches the standard of the Firebase add/patch/delete server functions, since they both use
/// JSON object with key/id storage.
///
// TODO: Any error handling on storage await errors?
///
class StorageLocalHelper {
  static late SharedPreferences shared;

  static Future<void> init() async {
    shared = await SharedPreferences.getInstance();
  }

  /// Add a locally stored JSON object, returning the UUID generated access key as the object's id.
  static Future<String?> addObject(Map<String, dynamic> data) async {
    String id = const Uuid().v1();
    await StorageLocalHelper.shared.setString(id, json.encode(data));
    return id;
  }

  /// Patch/Update an existing locally stored JSON object, from it's UUID key and new data.
  static Future<bool> patchObject(String key, Map<String, dynamic> data) async {
    await StorageLocalHelper.shared.setString(key, json.encode(data));
    return true;
  }

  /// Delete a locally stored JSON object using it's UUID key.
  static Future<bool> deleteObject(String key) async {
    await StorageLocalHelper.shared.remove(key);
    return true;
  }

  /// Load an generic object from it's id.
  /// check if the return can be JSON decoded into a Flutter Map<String, dynamic>.
  /// return the map, or null on any failure.
  static Future<Map<String, dynamic>?> getMapFromJson(String id) async {
    String? data = shared.getString(id);
    if (data == null) return null;
    var item = json.decode(data);
    if (item is Map<String, dynamic>) {
      return item;
    }
    return null;
  }
}

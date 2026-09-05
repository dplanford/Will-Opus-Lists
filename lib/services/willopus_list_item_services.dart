import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';
import 'package:willopuslists/constants.dart';

class WillOpusListItemServices {
  /// grab a list item from it's key/id.
  static Future<WillOpusListItem?> getItem(String key) async {
    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return null;
    }

    var map = await WillOpusSharedPrefs.shared.getMapFromJsonKey(key);
    if (map != null) {
      return WillOpusListItem.fromJson(map);
    }
    return null;
  }

  /// Add a list item object, using it's initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new list item assumes a null id, which is set by the add process.
  //  - in local storage, this assigns a uuid
  //  - in future online (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addItem(WillOpusListItem item) async {
    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return null;
    }

    item.id = const Uuid().v1();
    await WillOpusSharedPrefs.shared.setString(item.id, json.encode(item.toJson()));
    return item.id;
  }

  /// Update a list item object, using it's key/id.
  static Future<bool> patchItem(WillOpusListItem item) async {
    if (item.id == null) return false;

    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return false;
    }

    await WillOpusSharedPrefs.shared.setString(item.id, json.encode(item.toJson()));
    return true;
  }

  /// Delete a list item object, using it's key/id.
  static Future<bool> deleteItem(WillOpusListItem item) async {
    if (item.id == null) return false;

    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return false;
    }

    await WillOpusSharedPrefs.shared.remove(item.id!);
    return false;
  }
}

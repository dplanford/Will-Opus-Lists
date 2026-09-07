import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/firebase_storage_helper.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';

/// List Item object storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
class WillOpusListItemServices {
  /// grab a list item from it's key/id.
  static Future<WillOpusListItem?> getItem(
    String key, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      // TODO: Missed this Firebase call!
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
  //  - in online cloud storage (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      // TODO: setup Firebase service
      String? newId = await FirebaseStorageHelper.addObject(item.toJson());
      item.id = newId;
      return newId;
    }

    item.id = const Uuid().v1();
    await WillOpusSharedPrefs.shared.setString(item.id, json.encode(item.toJson()));
    return item.id;
  }

  /// Update a list item object, using it's key/id and updated data.
  static Future<bool> patchItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (item.id == null) return false;

    if (onCloud) {
      return (await FirebaseStorageHelper.patchObject(item.id!, item.toJson()));
    }

    await WillOpusSharedPrefs.shared.setString(item.id, json.encode(item.toJson()));
    return true;
  }

  /// Delete a list item object, using it's key/id.
  static Future<bool> deleteItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (item.id == null) return false;

    if (onCloud) {
      return (FirebaseStorageHelper.deleteObject(item.id!));
    }

    await WillOpusSharedPrefs.shared.remove(item.id!);
    return false;
  }
}

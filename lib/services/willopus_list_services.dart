import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/helper/firebase_storage_helper.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';

/// List object storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
class WillOpusListServices {
  /// Grab a list object from it's key/id.
  static Future<WillOpusList?> getList(
    String key, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      // TODO: setup Firebase service
      return null;
    }

    var map = await WillOpusSharedPrefs.shared.getMapFromJsonKey(key);
    if (map != null) {
      return WillOpusList.fromJson(map);
    }
    return null;
  }

  /// Add a list object, using it's initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new list assumes a null id, which is set by the add process.
  //  - in local storage, this assigns a uuid
  //  - in online cloud storage (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addList(
    WillOpusList list, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      String? newId = await FirebaseStorageHelper.addObject(list.toJson());
      list.id = newId;
      return newId;
    }

    list.id = const Uuid().v1();
    await WillOpusSharedPrefs.shared.setString(list.id, json.encode(list.toJson()));
    return list.id;
  }

  /// Update a list object, using it's key/id.
  static Future<bool> patchList(
    WillOpusList list, {
    bool onCloud = false,
  }) async {
    if (list.id == null) return false;

    if (onCloud) {
      return (await FirebaseStorageHelper.patchObject(list.id!, list.toJson()));
    }

    await WillOpusSharedPrefs.shared.setString(list.id, json.encode(list.toJson()));
    return true;
  }

  /// Delete a list object, using it's key/id.
  static Future<bool> deleteList(
    WillOpusList list, {
    bool onCloud = false,
  }) async {
    if (list.id == null) return false;

    if (onCloud) {
      return (FirebaseStorageHelper.deleteObject(list.id!));
    }

    await WillOpusSharedPrefs.shared.remove(list.id!);
    return false;
  }
}

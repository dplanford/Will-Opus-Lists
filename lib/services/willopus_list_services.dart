import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/helper/storage_firebase_helper.dart';
import 'package:willopuslists/helper/storage_local_helper.dart';

/// List object storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
class WillOpusListServices {
  /// Grab a list object from it's id.
  static Future<WillOpusList?> getList(
    String id, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      var map = await StorageFirebaseHelper.getMapFromJson(id);
      if (map != null) {
        return WillOpusList.fromJson(map);
      }
      return null;
    }

    var map = await StorageLocalHelper.getMapFromJson(id);
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
      String? newId = await StorageFirebaseHelper.addObject(list.toJson());
      list.id = newId;
      return newId;
    }

    list.id = const Uuid().v1();
    await StorageLocalHelper.shared.setString(list.id!, json.encode(list.toJson()));
    return list.id;
  }

  /// Update a list object, using it's key/id.
  static Future<bool> patchList(
    WillOpusList list, {
    bool onCloud = false,
  }) async {
    if (list.id == null) return false;

    if (onCloud) {
      return (await StorageFirebaseHelper.patchObject(list.id!, list.toJson()));
    }

    if (list.id != null) {
      await StorageLocalHelper.shared.setString(list.id!, json.encode(list.toJson()));
      return true;
    }
    return false;
  }

  /// Delete a list object, using it's key/id.
  static Future<bool> deleteList(
    WillOpusList list, {
    bool onCloud = false,
  }) async {
    if (list.id == null) return false;

    if (onCloud) {
      return (StorageFirebaseHelper.deleteObject(list.id!));
    }

    if (list.id != null) {
      await StorageLocalHelper.shared.remove(list.id!);
      return true;
    }
    return false;
  }
}

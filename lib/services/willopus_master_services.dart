import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:willopuslists/helper/storage_firebase_helper.dart';

import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/helper/storage_local_helper.dart';
import 'package:willopuslists/constants.dart';

/// Master List storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
class WillOpusMasterServices {
  /// get the master key, the id of the stored master list object.
  static Future<String?> getMasterKey() async {
    return await StorageLocalHelper.shared.getString(kMasterIDKey);
  }

  /// set the stored local key to the master list object.
  /// Returns bool in case future setup requires returning an error.
  static Future<bool> setMasterKey(String key) async {
    await StorageLocalHelper.shared.setString(kMasterIDKey, key);
    return true;
  }

  /// Grab the user's master list object, from it's key.
  static Future<WillOpusMasterList?> getMasterList(
    String key, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      var map = await StorageFirebaseHelper.getMapFromJsonKey(key);
      if (map != null) {
        return WillOpusMasterList.fromJson(map);
      }
      return null;
    }

    var map = await StorageLocalHelper.getMapFromJsonKey(key);
    if (map != null) {
      return WillOpusMasterList.fromJson(map);
    }
    return null;
  }

  /// Add a new master list object, using initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new master list assumes a null id, which is set by the add process.
  //  - in local storage, this assigns a uuid
  //  - in online cloud storage (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      String? newId = await StorageFirebaseHelper.addObject(masterList.toJson());
      masterList.id = newId;
      return newId;
    }

    masterList.id = const Uuid().v1();
    await StorageLocalHelper.shared.setString(masterList.id!, json.encode(masterList.toJson()));
    return masterList.id;
  }

  /// Update a master list object, using it's key/id.
  static Future<bool> patchMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      return (await StorageFirebaseHelper.patchObject(masterList.id!, masterList.toJson()));
    }

    if (masterList.id != null) {
      await StorageLocalHelper.shared.setString(masterList.id!, json.encode(masterList.toJson()));
      return true;
    }
    return false;
  }

  /// Delete a master list object, using it's key/id.
  /// This should never be done in-app unless some emergency reset....
  /// Set up the capability to match other similar object services.
  static Future<bool> deleteMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (masterList.id == null) return false;

    if (onCloud) {
      return (StorageFirebaseHelper.deleteObject(masterList.id!));
    }

    if (masterList.id != null) {
      await StorageLocalHelper.shared.remove(masterList.id!);
      return true;
    }
    return false;
  }
}

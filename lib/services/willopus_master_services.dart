import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:willopuslists/helper/firebase_storage_helper.dart';

import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';
import 'package:willopuslists/constants.dart';

/// Master List storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
class WillOpusMasterServices {
  /// get the master key, the id of the stored master list object.
  static Future<String?> getMasterKey() async {
    return await WillOpusSharedPrefs.shared.getString(kMasterIDKey);
  }

  /// set the stored local key to the master list object.
  /// Returns bool in case future setup requires returning an error.
  static Future<bool> setMasterKey(String key) async {
    await WillOpusSharedPrefs.shared.setString(kMasterIDKey, key);
    return true;
  }

  /// Grab the user's master list object, from it's key.
  static Future<WillOpusMasterList?> getMasterList(
    String key, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      // TODO: setup Firebase service
      return null;
    }

    var map = await WillOpusSharedPrefs.shared.getMapFromJsonKey(key);
    if (map != null) {
      return WillOpusMasterList.fromJson(map);
    }
    return null;
  }

  /// Add a new master list object, using initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new master list obj assumes a null object id, which is set by the add process.
  //  - in local storage, this assigns a uuid
  //  - in future online (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      String? newId = await FirebaseStorageHelper.addObject(masterList.toJson());
      masterList.id = newId;
      return newId;
    }

    masterList.id = const Uuid().v1();
    await WillOpusSharedPrefs.shared.setString(masterList.id, json.encode(masterList.toJson()));
    return masterList.id;
  }

  /// Update a master list object, using it's key/id.
  static Future<bool> patchMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      return (await FirebaseStorageHelper.patchObject(masterList.id!, masterList.toJson()));
    }

    await WillOpusSharedPrefs.shared.setString(masterList.id, json.encode(masterList.toJson()));
    return true;
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
      return (FirebaseStorageHelper.deleteObject(masterList.id!));
    }

    await WillOpusSharedPrefs.shared.remove(masterList.id);
    return false;
  }
}

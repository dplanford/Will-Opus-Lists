import 'package:willopuslists/helper/storage_firebase_helper.dart';

import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/helper/storage_local_helper.dart';
import 'package:willopuslists/constants.dart';

/// Master List storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
///
class WillOpusMasterServices {
  /// get the master key, the id of the stored master list object.
  static Future<String?> getMasterKey() async {
    return StorageLocalHelper.shared.getString(kMasterIDKey);
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
      var map = await StorageFirebaseHelper.getMapFromJson(key);
      if (map != null) {
        return WillOpusMasterList.fromJson(map);
      }
      return null;
    }

    var map = await StorageLocalHelper.getMapFromJson(key);
    if (map != null) {
      return WillOpusMasterList.fromJson(map);
    }
    return null;
  }

  /// Add a new master list object, using initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new master list object assumes a null id, which is set by the add process.
  //  - in local storage, this assigns a uuid as the returned id
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

    masterList.id = await StorageLocalHelper.addObject(masterList.toJson());
    return masterList.id;
  }

  /// Update a master list object in storage.
  static Future<bool> patchMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      return await StorageFirebaseHelper.patchObject(masterList.id!, masterList.toJson());
    }

    if (masterList.id != null) {
      return StorageLocalHelper.patchObject(masterList.id!, masterList.toJson());
    }
    return false;
  }

  /// Delete THE master list object, using it's key/id.
  /// NOTE!
  /// This should never be done in-app unless some emergency reset! Deleting this singleton
  /// user object deletes the master key to access all other data objects for this user!
  ///
  static Future<bool> deleteMasterList(
    WillOpusMasterList masterList, {
    bool onCloud = false,
  }) async {
    if (masterList.id == null) return false;

    if (onCloud) {
      return (StorageFirebaseHelper.deleteObject(masterList.id!));
    }

    if (masterList.id != null) {
      return StorageLocalHelper.deleteObject(masterList.id!);
    }

    return false;
  }
}

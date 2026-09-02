import 'dart:convert';

import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';
import 'package:willopuslists/constants.dart';

class WillOpusMasterServices {
  /// get the master key, the id of the stored master list object.
  static Future<String?> getMasterKey() async {
    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return null;
    }

    return await WillOpusSharedPrefs.shared.getString(kMasterIDKey);
  }

  /// set the stored local key to the master list object.
  static Future<bool> setMasterKey(String key) async {
    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return false;
    }

    await WillOpusSharedPrefs.shared.setString(kMasterIDKey, key);
    return true;
  }

  /// Grab the user's master lists object.
  static Future<WillOpusMasterList?> getMasterList(String key) async {
    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return null;
    }

    var map = await WillOpusSharedPrefs.shared.getMapFromJsonKey(key);
    if (map != null) {
      return WillOpusMasterList.fromJson(map);
    }
    return null;
  }

  /// Set/Update the master lists object.
  static Future<bool> setMasterList(WillOpusMasterList masterList) async {
    if (masterList.id == null || masterList.id!.isEmpty) return false;

    if (kUseOnlineServices) {
      // TODO: setup Firebase service
      return false;
    }

    await WillOpusSharedPrefs.shared.setString(masterList.id!, json.encode(masterList.toJson()));
    return true;
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// Handle Local Storage of app data.
class WillOpusSharedPrefs {
  static SharedPreferences? _shared;

  /// Upon first call, instantiate. otherwise return the singlton.
  static get shared async {
    if (_shared == null) {
      try {
        _shared = await SharedPreferences.getInstance();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return _shared;
  }

  /// Load an generic object from it's key...
  /// check if the return can be JSON decoded into a Flutter Map<String, dynamic>.
  /// return the Map, or null on any failure.
  Future<Map<String, dynamic>?> getMapFromJsonKey(String key) async {
    String? data = await WillOpusSharedPrefs.shared.getString(key);
    if (data == null) return null;
    var item = json.decode(data);
    if (item is Map<String, dynamic>) {
      return item;
    }
    return null;
  }
}

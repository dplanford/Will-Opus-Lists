import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WillOpusSharedPrefs {
  static SharedPreferences? _shared;

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

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
}

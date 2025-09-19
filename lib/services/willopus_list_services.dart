import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_shared_preferences_helper.dart';
import 'package:willopuslists/constants.dart';

class WillOpusListServices {
  static Future<List<WillOpusListItem>> getAllItems() async {
    List<WillOpusListItem> itemList = [];

    if (kUseOnlineServices) {
      var uri = Uri.https(
        kFirebaseUrl,
        '$kTestFile.json',
      );

      try {
        final response = await http.get(uri);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var data = json.decode(response.body);
          if (data is Map<String, dynamic>) {
            for (var itemKey in data.keys) {
              data[itemKey]['id'] = itemKey;
              itemList.add(WillOpusListItem.fromJson(data[itemKey]));
            }
          }
          return itemList;
        } else {
          return [];
        }
      } catch (err) {
        return [];
      }
    } else {
      List<WillOpusListItem> itemList = [];
      try {
        var sharedPrefs = await WillOpusSharedPrefs.shared.getKeys();
        var itemKeys = await sharedPrefs.getKeys();
        for (var itemKey in itemKeys) {
          var data = await WillOpusSharedPrefs.shared.getString(itemKey);
          if (data == null) break;

          var item = json.decode(data);
          if (item is Map<String, dynamic>) {
            item['id'] = itemKey;
            itemList.add(WillOpusListItem.fromJson(item));
          }
        }
        return itemList;
      } catch (e) {
        return [];
      }
    }
  }

  static Future<bool> addItem(WillOpusListItem item) async {
    if (kUseOnlineServices) {
      var uri = Uri.https(
        kFirebaseUrl,
        '$kTestFile.json',
      );

      try {
        final response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(item.toJson()),
        );
        debugPrint('response status code = ${response.statusCode}');
        return response.statusCode >= 200 && response.statusCode < 300;
      } catch (err) {
        return false;
      }
    } else {
      var itemKey = const Uuid().v1();
      await WillOpusSharedPrefs.shared.setString(itemKey, json.encode(item.toJson()));
      return true;
    }
  }

  static Future<bool> patchItem(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (kUseOnlineServices) {
      var patchUrl = Uri.https(
        kFirebaseUrl,
        '$kTestFile/${item.id}.json',
      );
      try {
        var response = await http.patch(
          patchUrl,
          body: json.encode(item.toJson()),
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      await WillOpusSharedPrefs.shared.setString(item.id!, json.encode(item.toJson()));
      return true;
    }
  }

  static Future<bool> deleteItem(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (kUseOnlineServices) {
      var delUrl = Uri.https(
        kFirebaseUrl,
        '$kTestFile/${item.id}.json',
      );

      try {
        var response = await http.delete(delUrl);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      await WillOpusSharedPrefs.shared.remove(item.id!);
      return true;
    }
  }

  static Future<bool> updateItemCurIndex(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (kUseOnlineServices) {
      var patchUrl = Uri.https(
        kFirebaseUrl,
        '$kTestFile/${item.id}.json',
      );

      try {
        var response = await http.patch(
          patchUrl,
          body: json.encode({'index': item.curIndex}),
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      await WillOpusSharedPrefs.shared.setString(item.id!, json.encode(item.toJson()));
      return true;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/constants.dart';

class ListServices {
  static bool useOnlineServices = false;
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<List<WillOpusListItem>> getAllItems() async {
    List<WillOpusListItem> itemList = [];

    if (ListServices.useOnlineServices) {
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
        var itemKeys = sharedPreferences.getKeys();
        for (var itemKey in itemKeys) {
          var data = sharedPreferences.getString(itemKey);
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
    if (ListServices.useOnlineServices) {
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
      await sharedPreferences.setString(itemKey, json.encode(item.toJson()));
      return true;
    }
  }

  static Future<bool> patchItem(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (ListServices.useOnlineServices) {
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
      await sharedPreferences.setString(item.id!, json.encode(item.toJson()));
      return true;
    }
  }

  static Future<bool> deleteItem(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (ListServices.useOnlineServices) {
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
      await sharedPreferences.remove(item.id!);
      return true;
    }
  }

  static Future<bool> updateItemCurIndex(WillOpusListItem item) async {
    if (item.id == null || item.id!.isEmpty) return false;

    if (ListServices.useOnlineServices) {
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
      await sharedPreferences.setString(item.id!, json.encode(item.toJson()));
      return true;
    }
  }
}

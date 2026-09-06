import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:willopuslists/constants.dart';

class FirebaseStorageHelper {
  static Future<String?> addObject(Map<String, dynamic> data) async {
    var uri = Uri.https(
      kFirebaseUrl,
      '$kTestFile.json',
    );

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // TODO: Return the key id returned by firebase! Look this up!!!
        return 'NEED_ID_FROM_FIREBASE_ADD_NEW_OBJ';
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future<bool> patchObject(String key, Map<String, dynamic> data) async {
    var uri = Uri.https(
      kFirebaseUrl,
      '$kTestFile/${key}.json',
    );

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> deleteObject(String key) async {
    var uri = Uri.https(
      kFirebaseUrl,
      '$kTestFile/${key}.json',
    );

    try {
      final response = await http.delete(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }
}



/*
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
*/
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:willopuslists/constants.dart';

/// Firebase Cloud storage access helper.
/// NOTE: This is preliminary, and based on working code from an older test of Firebase services.
/// This test used a temporary 30 day trial access to a development Firebase cloud account, with no
/// authentication needed.
///
/// NOTE: All services used in this app generally follow the Firebase model of add/patch/delete of
/// JSON data objects. This includes adapting this model to local storage to maximize future Firebase
/// possible usage.
///
/// This code will currently fail if you set the on-line flag (not a valid Firebase account set up).
/// It's included for future usage, and as an example.
///
/// TODO: If I ever do add Firebase cloud storage to the app, I need to move the kUseOnlineServices
/// global test variable into an input for each service call... default to local, but set the flag
/// for sending to cloud.
///
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
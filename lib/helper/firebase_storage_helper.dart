import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:willopuslists/constants.dart';

/// Firebase Cloud storage access helper.
/// NOTE: This is preliminary, and based on working code from an older test of Firebase services.
/// This older test used a temporary 30 day trial access to an open development Firebase cloud
/// account, with no authentication needed. Any future actual implementation of Firebase cloud
/// storage would need the app to handle authentication, especially if I expand this to larger
/// multi-user functionality.
///
/// NOTE: All services used in this app generally follow the Firebase model of get/add/patch/delete
/// of JSON data objects. This includes adapting this model to matching local storage to maximize
/// future Firebase adaptations.
///
/// This code will currently fail if you set the cloud on-line flag on any of the app's service
/// calls (my old 30 day test Firebase account is long dead).
///
/// This code is included for future usage, and as an example.
///
/// NOTE: This currently uses simple direct HTTP communications with the Firebase server (per their
/// old tutorials). Proper future setup to handle user authentication on each HTTP request & error
/// handling might be better handled by a Flutter tool like Dio.
///
class FirebaseStorageHelper {
  /// Add a Firebase JSON object, returning the Firebase generated access key.
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

  /// Path/Update an existing Firebase JSON object, from it's Firebase key and new data.
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

  /// Delete a Firebase JSON object using it's Firebase key.
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
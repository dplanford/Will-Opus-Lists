import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/storage_firebase_helper.dart';
import 'package:willopuslists/helper/storage_local_helper.dart';

/// List Item object storage services.
/// Inputting the "onCloud = true" input on any service call that includes it sends the
/// object data call to the Firebase cloud service, rather than local storage services.
///
class WillOpusListItemServices {
  /// grab a list item from it's id.
  static Future<WillOpusListItem?> getItem(
    String id, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      var map = await StorageFirebaseHelper.getMapFromJson(id);
      if (map != null) {
        return WillOpusListItem.fromJson(map);
      }
      return null;
    }

    var map = await StorageLocalHelper.getMapFromJson(id);
    if (map != null) {
      return WillOpusListItem.fromJson(map);
    }
    return null;
  }

  /// Add a new list item object, using it's initial values.
  /// Returns the key ID to the new object, null on error.
  //
  // Adding a new list item assumes a null object id, which is set by the add process.
  //  - in local storage, this assigns a uuid as the returned id
  //  - in online cloud storage (Firebase), this uses the id returned by the Firebase server.
  static Future<String?> addItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (onCloud) {
      item.id = await StorageFirebaseHelper.addObject(item.toJson());
      return item.id;
    }

    item.id = await StorageFirebaseHelper.addObject(item.toJson());
    return item.id;
  }

  /// Update an existing list item object in storage.
  static Future<bool> patchItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (item.id == null) return false;

    if (onCloud) {
      return await StorageFirebaseHelper.patchObject(item.id!, item.toJson());
    }

    if (item.id != null) {
      return await StorageLocalHelper.patchObject(item.id!, item.toJson());
    }

    return false;
  }

  /// Delete a list item object from storage, using it's key/id.
  static Future<bool> deleteItem(
    WillOpusListItem item, {
    bool onCloud = false,
  }) async {
    if (item.id == null) return false;

    if (onCloud) {
      return await StorageFirebaseHelper.deleteObject(item.id!);
    }

    if (item.id != null) {
      return await StorageLocalHelper.deleteObject(item.id!);
    }
    return false;
  }
}

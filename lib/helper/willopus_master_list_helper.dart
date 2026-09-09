//import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/services/willopus_master_services.dart';

class WillOpusMasterListHelper {
  /// Get the user's singular master list object.
  /// If no master object key is yet stored, then create a new empty master list.
  /// If an error occurs (master list is supposed to exist, but does not load, or similar), return null.
  ///
  /// Only one master list object should ever exist for a user!
  ///
  static Future<WillOpusMasterList?> getMaster() async {
    // Grab the locally stored master key to the master list object.
    String? masterId = await WillOpusMasterServices.getMasterKey();
    if (masterId == null) {
      // No master key stored yet... create a new master list object.
      var masterList = WillOpusMasterList();
      masterId = await WillOpusMasterServices.addMasterList(masterList);
      if (masterId != null) {
        // master list object stored... store the key to it in local storage.
        WillOpusMasterServices.setMasterKey(masterId);
        return masterList;
      }
      // Error - catch all is sometheng went wrong.
      return null;
    }

    // Now that we have the master key, try to grab the master object from storage.
    WillOpusMasterList? masterList = await WillOpusMasterServices.getMasterList(masterId);
    if (masterList == null) {
      // Error... we have a stored key, but no associated object.
      // TODO: Create a new master list, thus starting from scratch?
      // Try to recover by searching for a stored master list object with a malformed key?
      // There should never be more than one master list object stored per user....
      return null;
    }

    return masterList;
  }
}

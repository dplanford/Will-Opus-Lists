//import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/services/willopus_master_services.dart';

class WillOpusMasterListHelper {
  Future<WillOpusMasterList?> getMaster() async {
    String? masterId = await WillOpusMasterServices.getMasterKey();
    if (masterId == null) {
      // No master key stored yet... create a new master list object.
      var masterList = WillOpusMasterList();
      masterId = await WillOpusMasterServices.addMasterList(masterList);
      if (masterId != null) {
        WillOpusMasterServices.setMasterKey(masterId);
        return masterList;
      }
      return null;
    }

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

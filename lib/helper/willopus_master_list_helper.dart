import 'package:willopuslists/model/willopus_master_list.dart';

class WillOpusMasterHelper {
  static List<WillOpusMasterList> masterList = [];

  static void sortByCurIndex() {
    masterList.sort(
      (WillOpusMasterList a, WillOpusMasterList b) {
        if (a.curIndex < b.curIndex) {
          return -1;
        } else if (a.curIndex > b.curIndex) {
          return 1;
        } else {
          return 0;
        }
      },
    );

    updateSortIndexes();
  }

  // TODO: on re-order & delete, update the needed item curIndexes, and return a list of
  // updated items. WillOpusMasterListHelper's to be updated just in the curIndex field (need to set up a
  // specialized service call for just updating a list of items with only curIndex changes...)
  static List<WillOpusMasterList> updateSortIndexes() {
    List<WillOpusMasterList> updatedItems = [];
    for (int i = 0; i < masterList.length; i = i + 1) {
      if (i != masterList[i].curIndex) {
        masterList[i].curIndex = i;
        // TODO: Master list services (including hooks for Firebase)
        //WillOpusServices.patchItem(masterList[i]);
      }
    }
    // TODO: setup specialized "just update the index for each item" for these sorting changes!
    return updatedItems;
  }

  static void reorderMasterList(int indexA, indexB) {
    var tmpItem = masterList[indexA];
    masterList.removeAt(indexA);
    masterList.insert(indexB, tmpItem);
    // TODO
    //WillOpusMasterListHelperHelper.updateSortIndexes();
  }

  /*
  static List<ReorderableTableRow> tableRows({void Function()? refreshParent}) {
    List<ReorderableTableRow> tableRows = [];
    for (var item in WillOpusMasterListHelperHelper.masterList) {
      tableRows.add(
        ReorderableTableRow(
          key: ObjectKey(item),
          children: [
            WillOpusMasterListHelperTile(
              item: item,
              refreshParent: refreshParent,
            ),
          ],
        ),
      );
    }
    return tableRows;
  }
*/
}

import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/services/list_services.dart';
import 'package:willopuslists/widgets/willopus_list_tile.dart';

class ListHelper {
  static List<WillOpusListItem> itemsList = [];

  static void sortByCurIndex() {
    itemsList.sort(
      (WillOpusListItem a, WillOpusListItem b) {
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
  // updated items. WillOpusListItem's to be updated just in the curIndex field (need to set up a
  // specialized service call for just updating a list of items with only curIndex changes...)
  static List<WillOpusListItem> updateSortIndexes() {
    List<WillOpusListItem> updatedItems = [];
    for (int i = 0; i < itemsList.length; i = i + 1) {
      if (i != itemsList[i].curIndex) {
        itemsList[i].curIndex = i;
        ListServices.patchItem(itemsList[i]);
      }
    }
    // TODO: setup specialized "just update the index for each item" for these sorting changes!
    return updatedItems;
  }

  static void reorderListTiles(int indexA, indexB) {
    var tmpItem = itemsList[indexA];
    itemsList.removeAt(indexA);
    itemsList.insert(indexB, tmpItem);
    ListHelper.updateSortIndexes();
  }

  static List<ReorderableTableRow> tableRows({void Function()? refreshParent}) {
    List<ReorderableTableRow> tableRows = [];
    for (var item in ListHelper.itemsList) {
      tableRows.add(
        ReorderableTableRow(
          key: ObjectKey(item),
          children: [
            WillOpusListTile(
              item: item,
              refreshParent: refreshParent,
            ),
          ],
        ),
      );
    }
    return tableRows;
  }
}

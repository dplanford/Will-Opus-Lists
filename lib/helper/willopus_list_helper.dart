// TODO: REWORK THIS! No more sort indexes, since sorting is handled by ID order held by the current list.

//import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/services/willopus_list_item_services.dart';
//import 'package:willopuslists/services/willopus_list_services.dart';
//import 'package:willopuslists/widgets/willopus_list_item_tile.dart';

class WillOpusListHelper {
  /// Return a matching list of loaded items from a list of IDs for the stored item objects.
  // TODO: Update/move?, to handle displaying each item as it gets async loaded?
  // This should be handled in the list screen, with async loading?
  static Future<List<WillOpusListItem>> getItemsFromIds(List<String> itemIds) async {
    List<WillOpusListItem> items = [];
    for (String id in itemIds) {
      WillOpusListItem? item = await WillOpusListItemServices.getItem(id);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }

  // TODO: Remove from here! Not needed, but still referenced once in the list screen.
  static List<WillOpusListItem> updateSortIndexes() {
    return [];
  }

  static void reorderListTiles(int indexA, int indexB) {
    // TODO: Need to move this to the list screen? So it can access the screen's current list,

    // TODO: Check if this works? My brain wants to say it should insert at indexB-1,
    // to handle the removed item?

    //var tmpItem = itemsList[indexA];
    //itemsList.removeAt(indexA);
    //itemsList.insert(indexB, tmpItem);
  }

  // TODO: Get this working again! And move to the list screen?
  static List<ReorderableTableRow> tableRows({void Function()? refreshParent}) {
    /*
    List<ReorderableTableRow> tableRows = [];
    for (var item in WillOpusListHelper.itemsList) {
      tableRows.add(
        ReorderableTableRow(
          key: ObjectKey(item),
          children: [
            WillOpusListItemTile(
              item: item,
              refreshParent: refreshParent,
            ),
          ],
        ),
      );
    }
    return tableRows;
    */
    return [];
  }
}

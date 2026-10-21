import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';
import 'package:willopuslists/helper/snackbar_helper.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_list_helper.dart';
import 'package:willopuslists/services/willopus_list_item_services.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/screens/willopus_list_item_details_screen.dart';

// Auto-generated
import 'package:willopuslists/l10n/app_localizations.dart';
import 'package:willopuslists/widgets/willopus_list_item_tile.dart';

enum _ItemSaveOutcomes { none, cancelled, error }

/// Screen for displaying/updating a list of task items.
///
class WillOpusListScreen extends StatefulWidget {
  final String listId;

  const WillOpusListScreen(
    this.listId, {
    super.key,
  });

  @override
  State<WillOpusListScreen> createState() => _WillOpusListScreenState();
}

class _WillOpusListScreenState extends State<WillOpusListScreen> {
  WillOpusList? list;
  List<WillOpusListItem> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _listBody(),
    );
  }

  /// Show the appbar screen header
  AppBar _appbar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // TODO: Adjust top appbar header to display a thin color bar with the list's hex-color
      // - on top of the string title display....
      // - Small Column widget for the title, rather than just a centered text widget....
      title: Center(child: Text(list != null ? list!.title : AppLocalizations.of(context)!.baseError)),
      actions: [
        /*
        if (!isLoading && kUseOnlineServices)
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              _fetchData();
            },
          ),
        */
        if (!isLoading)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              _ItemSaveOutcomes added = await _addNewItem();
              // Show an appropriate snack-bar text.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                String snackbarText = '';
                switch (added) {
                  case _ItemSaveOutcomes.none:
                    snackbarText = AppLocalizations.of(context)!.snackbarItemAdded;
                    break;
                  case _ItemSaveOutcomes.error:
                    snackbarText = AppLocalizations.of(context)!.snackbarItemAddFailed;
                    break;
                  case _ItemSaveOutcomes.cancelled:
                    return;
                }
                SnackbarHelper.showSnackBar(context, snackbarText);
              });
            },
          ),
      ],
    );
  }

  /// Show the core list screen.
  Widget _listBody() {
    if (isLoading) {
      return const Center(child: AdaptiveCircularProgressIndicator());
    }

    if (list == null) {
      return Center(child: Text(AppLocalizations.of(context)!.listErrNoObj));
    }

    if (list!.itemIds.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.listEmpty));
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: ReorderableTable(
              onReorder: (a, int b) {
                setState(() {
                  WillOpusListHelper.reorderListTiles(a, b);
                });
              },
              children: _listItems(),
            ),
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          height: 64,
        ),
      ],
    );
  }

  /// Get a list and all it's items from storage.
  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    list = await WillOpusListServices.getList(widget.listId);
    if (list == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    List<WillOpusListItem> listItems = await WillOpusListHelper.getItemsFromIds(list!.itemIds);

    setState(() {
      items = listItems;
      isLoading = false;
    });
  }

  /// return the list of items to display.
  List<ReorderableTableRow> _listItems() {
    List<ReorderableTableRow> tableRows = [];
    for (var item in items) {
      tableRows.add(
        ReorderableTableRow(
          key: ObjectKey(item),
          children: [
            WillOpusListItemTile(
              item: item,
              refreshParent: _fetchData,
            ),
          ],
        ),
      );
    }
    return tableRows;
  }

  /// Add a new list item to storage and display on this screen.
  /// Returns false on storage failure or add was cancelled.
  Future<_ItemSaveOutcomes> _addNewItem() async {
    var newItem = WillOpusListItem();

    // Allow the user to edit the new item.
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WillOpusListItemDetailsScreen(item: newItem),
      ),
    );

    if (newItem.title.isEmpty) {
      // User cancelled new item.
      return _ItemSaveOutcomes.cancelled;
    }

    // Add the new item to storage.
    String? addedId = await WillOpusListItemServices.addItem(newItem);
    if (addedId == null) {
      return _ItemSaveOutcomes.error;
    }

    // Add the new item's id the top of this list for storage.
    if (list != null) {
      list!.itemIds.insert(0, addedId);
      bool listPatched = await WillOpusListServices.patchList(list!);
      if (listPatched) {
        // Add the new item to the top of this list for display.
        setState(() {
          items.insert(0, newItem);
        });
        return _ItemSaveOutcomes.none;
      }
    }

    return _ItemSaveOutcomes.error;
  }

  /// Patch an existing list item.
  /// Returns false on storage error.
  Future<_ItemSaveOutcomes> _patchItem(WillOpusListItem item) async {
    // Allow the user to edit the item.
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WillOpusListItemDetailsScreen(item: item),
      ),
    );

    // TODO: Setup a way to detect cancelled here?
    // Could set up a comparison for changes? (copy the item, then compare details update to copy?)

    // Patch the item in storage.
    bool patched = await WillOpusListItemServices.patchItem(item);
    if (patched) {
      return _ItemSaveOutcomes.none;
    } else {
      return _ItemSaveOutcomes.error;
    }
    /*{
        snackBarText = AppLocalizations.of(context)!.snackbarItemUpdated;
      } else {
        snackBarText = AppLocalizations.of(context)!.snackbarItemUpdateFailed;
    */
  }
}

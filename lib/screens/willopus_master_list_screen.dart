import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/helper/snackbar_helper.dart';
import 'package:willopuslists/helper/willopus_master_list_helper.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/services/willopus_master_services.dart';
import 'package:willopuslists/widgets/adaptive_alert_dialog.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/widgets/willopus_list_edit_dialog.dart';
import 'package:willopuslists/widgets/willopus_list_tile.dart';

// Auto-generated
import 'package:willopuslists/l10n/app_localizations.dart';

/// A screen for displaying the user's master/main list screen... the screen showing all the user's
/// color-coded lists.
class WillOpusMasterListScreen extends StatefulWidget {
  const WillOpusMasterListScreen({super.key});

  @override
  State<WillOpusMasterListScreen> createState() => _WillOpusMasterListScreenState();
}

class _WillOpusMasterListScreenState extends State<WillOpusMasterListScreen> {
  WillOpusMasterList? masterList;
  List<WillOpusList> lists = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(AppLocalizations.of(context)!.appTitle)),
        actions: [
          if (!isLoading)
            IconButton(
              onPressed: () async {
                if (masterList == null) return; // ERROR, but should be caught before here....
                // TODO: add error handling?

                // Open the dialog for creating a new list.
                WillOpusList? newList = await WillOpusListEditDialog.show(context);
                if (newList == null) return;

                // Add the new list to storage.
                String? newId = await WillOpusListServices.addList(newList);
                if (newId == null) return; // error - failed to add the new list.
                // TODO: add error handling?

                newList.id = newId;

                // Add the new list's id to the top of the master object's list
                masterList!.listsIds.insert(0, newId);
                bool patched = await WillOpusMasterServices.patchMasterList(masterList!);
                if (patched) {
                  setState(() {
                    // Add the new list object to the top of the master display list.
                    lists.insert(0, newList);
                  });
                  // TODO: add error handling? Possibly remove the just added list object if this fails?
                }
              },
              icon: Icon(Icons.add),
            ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: _showMasterList(),
      ),
    );
  }

  /// Show the master screen core.
  Widget _showMasterList() {
    if (isLoading) {
      return const Center(child: AdaptiveCircularProgressIndicator());
    }

    if (masterList == null) {
      return Center(child: Text(AppLocalizations.of(context)!.masterErrObj));
    }

    if (lists.length <= 0) {
      return Center(child: Text(AppLocalizations.of(context)!.masterNoLists));
    }

    return ListView.separated(
      itemCount: lists.length,
      itemBuilder: (context, index) => WillOpusListTile(
        list: lists[index],
        updateList: (list) async {
          WillOpusList? editedList = await WillOpusListEditDialog.show(context, list: list);
          if (editedList != null) {
            bool patched = await WillOpusListServices.patchList(editedList);
            if (patched) {
              String toast = AppLocalizations.of(context)!.snackbarListUpdated;
              toast = toast.replaceFirst('@', list.title);
              SnackbarHelper.showSnackBar(context, toast);
              setState(() {});
            } else {
              String toast = AppLocalizations.of(context)!.snackbarListUpdateErr;
              toast = toast.replaceFirst('@', list.title);
              SnackbarHelper.showSnackBar(context, toast);
            }
          }
        },
        deleteList: (list) async {
          bool doDelete = await _showDeleteListDialog(list);
          if (!doDelete) return;
          bool deleted = await WillOpusListServices.deleteList(list);
          if (deleted) {
            // Remove the list's id from the master object.
            masterList!.listsIds.remove(list.id);
            bool patched = await WillOpusMasterServices.patchMasterList(masterList!);
            if (patched) {
              String toast = AppLocalizations.of(context)!.snackbarListDeleted;
              toast = toast.replaceFirst('@', list.title);
              SnackbarHelper.showSnackBar(context, toast);
              setState(() {
                // Remove the list's display tile.
                lists.remove(list);
              });
            } else {
              String toast = AppLocalizations.of(context)!.snackbarListDeleteErr;
              toast = toast.replaceFirst('@', list.title);
              SnackbarHelper.showSnackBar(context, toast);
            }
          }
        },
      ),
      separatorBuilder: (context, index) => Divider(color: Colors.grey), // Custom separator
    );
  }

  /// Grab the master list & all it's sub-lists from storage.
  Future<void> _fetchData() async {
    masterList = await WillOpusMasterListHelper.getMaster();
    if (masterList != null) {
      masterList!.listsIds.forEach((id) async {
        var list = await WillOpusListServices.getList(id);
        if (list != null) {
          lists.add(list);
        } else {
          // Add a dummy object in case of load object error, so the displayed objects
          // and the master list of object keys match.
          lists.add(WillOpusList(
            title: AppLocalizations.of(context)!.baseError,
            desc: AppLocalizations.of(context)!.masterMissingListForId,
          ));
        }
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _showDeleteListDialog(WillOpusList list) async {
    bool doDelete = false;

    String deleteQuery = AppLocalizations.of(context)!.deleteQuery;
    deleteQuery = deleteQuery.replaceFirst('@', '\"${list.title}\"');

    await showDialog(
      context: context,
      builder: (context) {
        return AdaptiveAlertDialog(
          title: Text(AppLocalizations.of(context)!.itemDeleteQuery),
          content: Text(deleteQuery),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                doDelete = false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.delete),
              onPressed: () {
                doDelete = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return doDelete;
  }
}

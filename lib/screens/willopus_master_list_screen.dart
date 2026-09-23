import 'package:flutter/material.dart';
import 'package:willopuslists/helper/willopus_master_list_helper.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/services/willopus_master_services.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/widgets/willopus_list_create_dialog.dart';
import 'package:willopuslists/widgets/willopus_list_tile.dart';

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
        title: const Center(child: Text('Will-Opus Lists')),
        actions: [
          if (!isLoading)
            IconButton(
              onPressed: () async {
                // Open the dialog for creating/editing a new list.
                WillOpusList? newList = await WillOpusListCreateDialog.show(context);
                setState(() {
                  if (masterList != null && newList != null && newList.id != null) {
                    setState(() {
                      // Add the new list object to the top of the master list.
                      lists.insert(0, newList);
                    });
                    // Update storage of the master list object with the new list key/id added.
                    masterList!.listsIds.insert(0, newList.id!);
                    WillOpusMasterServices.patchMasterList(masterList!);
                  }
                });
              },
              icon: Icon(Icons.add),
            ),
        ],
      ),
      body: _showMasterList(),
    );
  }

  /// Show the master screen core.
  Widget _showMasterList() {
    if (isLoading) {
      return const Center(child: AdaptiveCircularProgressIndicator());
    }

    if (masterList == null) {
      return Center(child: Text('Error - Missing or Mismatched Master List!'));
    }

    if (lists.length <= 0) {
      return Center(child: Text('No lists yet!'));
    }

    return ListView.separated(
      itemCount: lists.length,
      itemBuilder: (context, index) => WillOpusListTile(list: lists[index]),
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
          lists.add(WillOpusList(title: 'ERROR', desc: 'Missing object for key.'));
        }
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}

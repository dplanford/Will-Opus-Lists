import 'package:flutter/material.dart';
import 'package:willopuslists/helper/willopus_color_helper.dart';
import 'package:willopuslists/helper/willopus_master_list_helper.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/model/willopus_master_list.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/widgets/willopus_list_create_dialog.dart';

class WillOpusMasterListScreen extends StatefulWidget {
  const WillOpusMasterListScreen({super.key});

  @override
  State<WillOpusMasterListScreen> createState() => _WillOpusMasterListScreenState();
}

class _WillOpusMasterListScreenState extends State<WillOpusMasterListScreen> {
  WillOpusMasterList? masterList;

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
                WillOpusList? newList = await WillOpusListCreateDialog.show(context);
                setState(() {
                  if (masterList != null && newList != null) {
                    masterList!.lists.add(newList);
                  }
                });
              },
              icon: Icon(Icons.add),
            ),
        ],
      ),
      body: isLoading ? const Center(child: AdaptiveCircularProgressIndicator()) : _showMasterList(),
    );
  }

  Widget _showMasterList() {
    if (masterList == null) {
      return Center(child: Text('Error - Missing or Mismatched Master List!'));
    }

    if (masterList!.lists.length <= 0) {
      return Center(child: Text('No lists yet!'));
    }
    return ListView.separated(
      itemCount: masterList!.lists.length,
      // TODO: 1st pass, wrap each container in a tap gesture widget of some sort
      // (Button instead of SizedBox would work?), tap goes to list screen with that list object's key id.
      // Probably switch to an actual Card widget, or at least basic ListTile?
      itemBuilder: (context, index) => Container(
        color: WillOpusColorHelper.colorFromHex(masterList!.lists[index].hexColor),
        child: SizedBox(
          height: 150.0,
          child: Center(child: Text(masterList!.lists[index].title)),
        ),
      ),
      separatorBuilder: (context, index) {
        return Divider(color: Colors.grey); // Custom separator
      },
    );
  }

  Future<void> _fetchData() async {
    masterList = await WillOpusMasterListHelper.getMaster();

    setState(() {
      isLoading = false;
    });
  }
}

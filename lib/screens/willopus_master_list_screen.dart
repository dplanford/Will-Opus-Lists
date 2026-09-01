import 'package:flutter/material.dart';
import 'package:willopuslists/helper/willopus_color_helper.dart';

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

  List<WillOpusList> currentLists = [];

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
                  if (newList != null) currentLists.add(newList);
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
    if (currentLists.length <= 0) {
      return Center(child: Text('No lists yet!'));
    }
    return ListView.separated(
      itemCount: currentLists.length,
      itemBuilder: (context, index) => Container(
        color: WillOpusColorHelper.colorFromHex(currentLists[index].hexColor),
        child: SizedBox(
          height: 150.0,
          child: Center(child: Text(currentLists[index].title)),
        ),
      ),
      separatorBuilder: (context, index) {
        return Divider(color: Colors.grey); // Custom separator
      },
    );
  }

  void _fetchData() {
    // TODO: fetch actual data here!
    setState(() {
      isLoading = false;
    });
  }
}

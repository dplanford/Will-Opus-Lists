import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/list_helper.dart';
import 'package:willopuslists/screens/willopus_list_item_details_screen.dart';
import 'package:willopuslists/services/list_services.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';

class WillOpusScreen extends StatefulWidget {
  const WillOpusScreen({super.key});

  @override
  State<WillOpusScreen> createState() => _WillOpusScreenState();
}

class _WillOpusScreenState extends State<WillOpusScreen> {
  bool isLoading = false;

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
          if (ListServices.useOnlineServices)
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () {
                _fetchData();
              },
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              var newItem = WillOpusListItem(curIndex: ListHelper.itemsList.length);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WillOpusListItemDetailsScreen(item: newItem, refreshParent: _fetchData),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: AdaptiveCircularProgressIndicator())
                : Container(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: ReorderableTable(
                      onReorder: (a, int b) {
                        setState(() {
                          ListHelper.reorderListTiles(a, b);
                        });
                      },
                      children: ListHelper.tableRows(refreshParent: _fetchData),
                    ),
                  ),
          ),
          Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            height: 64,
          ),
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    ListHelper.itemsList = [];
    setState(() {
      isLoading = true;
    });
    await ListServices.init();
    var items = await ListServices.getAllItems();
    setState(() {
      ListHelper.itemsList = items;
      ListHelper.sortByCurIndex();
      isLoading = false;
    });
  }
}

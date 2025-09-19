import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:uuid/uuid.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_list_helper.dart';
import 'package:willopuslists/screens/willopus_list_item_details_screen.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/constants.dart';

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
          if (kUseOnlineServices)
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () {
                _fetchData();
              },
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              var newItem = WillOpusListItem(
                curIndex: 0,
                // TODO:
                //image: WillOpusImage(
                //  imageBase64: base64.encode(
                //    utf8.encode(WillOpusImage.TEST_IMAGE),
                //  ),
                //),
              );

              if (!kUseOnlineServices) {
                newItem.id = const Uuid().v1();
              }

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
                          WillOpusListHelper.reorderListTiles(a, b);
                        });
                      },
                      children: WillOpusListHelper.tableRows(refreshParent: _fetchData),
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
    WillOpusListHelper.itemsList = [];
    setState(() {
      isLoading = true;
    });
    var items = await WillOpusListServices.getAllItems();
    setState(() {
      WillOpusListHelper.itemsList = items;
      WillOpusListHelper.sortByCurIndex();
      isLoading = false;
    });
  }
}

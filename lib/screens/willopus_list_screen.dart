import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

import 'package:willopuslists/model/willopus_list.dart';
import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_list_helper.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/widgets/adaptive_circular_indicator.dart';
import 'package:willopuslists/screens/willopus_list_item_details_screen.dart';
import 'package:willopuslists/constants.dart';

class WillOpusListScreen extends StatefulWidget {
  final String listId = '';

  const WillOpusListScreen(
    String listId, {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Will-Opus Lists')),
        actions: [
          if (!isLoading && kUseOnlineServices)
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () {
                _fetchData();
              },
            ),
          if (!isLoading)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                var newItem = WillOpusListItem(
                    //curIndex: 0,
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
      body: _listBody(),
    );
  }

  Future<void> _fetchData() async {
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

  Widget _listBody() {
    if (isLoading) {
      return const Center(child: AdaptiveCircularProgressIndicator());
    }

    if (list == null) {
      return Center(child: Text('ERROR - no list object associated with this key!'));
    }

    if (list!.itemIds.length <= 0) {
      return Center(child: Text('No items added to this list yet!'));
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
              children: WillOpusListHelper.tableRows(refreshParent: _fetchData),
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
}

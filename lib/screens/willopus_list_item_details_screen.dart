import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/snackbar_helper.dart';
import 'package:willopuslists/helper/willopus_list_helper.dart';
import 'package:willopuslists/services/willopus_list_services.dart';

class WillOpusListItemDetailsScreen extends StatefulWidget {
  final WillOpusListItem item;
  final void Function()? refreshParent;

  const WillOpusListItemDetailsScreen({super.key, required this.item, this.refreshParent});

  @override
  State<WillOpusListItemDetailsScreen> createState() => _WillOpusItemsListDetailsScreenState();
}

class _WillOpusItemsListDetailsScreenState extends State<WillOpusListItemDetailsScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item.title;
    _descController.text = widget.item.desc;
  }

  @override
  Widget build(BuildContext context) {
    String appbarTitle = widget.item.id == null || widget.item.id!.isEmpty ? 'Add Item' : 'Edit Item';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(appbarTitle)),
        // TODO: replace leading back button, like some MrOwl pages, to add a "You've made changes, are you sure?"
        // popup dialog before navigating back with unsaved changes...
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              bool doExit = false;
              String snackBarText = '';
              if (widget.item.id == null || widget.item.id!.isEmpty) {
                if (await WillOpusListServices.addItem(widget.item)) {
                  WillOpusListHelper.itemsList.insert(0, widget.item);
                  WillOpusListHelper.updateSortIndexes();
                  snackBarText = 'Item Added!';
                  doExit = true;
                } else {
                  snackBarText = 'Item failed to add...';
                }
              } else {
                if (await WillOpusListServices.patchItem(widget.item)) {
                  snackBarText = 'Item Updated!';
                  doExit = true;
                } else {
                  snackBarText = 'Item failed to updated...';
                }
              }
              _showSnackbar(snackBarText);

              if (doExit) {
                if (widget.refreshParent != null) {
                  widget.refreshParent!();
                }
                _exitScreen();
              }
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const Text('Item Title'),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    widget.item.title = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter a title',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Item Description'),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: _descController,
                  maxLines: 16,
                  onChanged: (value) {
                    widget.item.desc = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter a title',
                  ),
                ),
              ),
            ),
            if (widget.item.imagePath.isNotEmpty) const SizedBox(height: 24),
            if (widget.item.imagePath.isNotEmpty) CachedNetworkImage(imageUrl: widget.item.imagePath),
          ]),
        ),
      ),
    );
  }

  void _showSnackbar(String txt) {
    SnackbarHelper.showSnackBar(context, txt);
  }

  void _exitScreen() {
    Navigator.of(context).pop();
  }
}

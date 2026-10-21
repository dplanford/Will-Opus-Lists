import 'package:flutter/material.dart';
import 'package:willopuslists/helper/snackbar_helper.dart';

import 'package:willopuslists/model/willopus_list_item.dart';

// Auto-generated.
import 'package:willopuslists/l10n/app_localizations.dart';

/// Screen for editing a list item.
///
class WillOpusListItemDetailsScreen extends StatefulWidget {
  final WillOpusListItem item;

  const WillOpusListItemDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  State<WillOpusListItemDetailsScreen> createState() => _WillOpusItemsListDetailsScreenState();
}

class _WillOpusItemsListDetailsScreenState extends State<WillOpusListItemDetailsScreen> {
  WillOpusListItem editItem = WillOpusListItem();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  bool changed = false;

  @override
  void initState() {
    super.initState();

    editItem = widget.item.clone();

    _titleController.text = widget.item.title;
    _descController.text = widget.item.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: _appBar(),
      body: _detailsBody(),
    );
  }

  AppBar _appBar() {
    String appbarTitle;
    if (editItem.id == null || editItem.id!.isEmpty) {
      appbarTitle = AppLocalizations.of(context)!.screenTitleAddItem;
    } else {
      appbarTitle = AppLocalizations.of(context)!.screenTitleEditItem;
    }

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Center(child: Text(appbarTitle)),
      // TODO: replace leading back button, like some MrOwl pages, to add a "You've made changes, are you sure?"
      // popup dialog before navigating back with unsaved changes... Used local "changed" boolean.
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () async {
            if (editItem.title.isEmpty) {
              // TODO: Localize.
              SnackbarHelper.showSnackBar(context, 'Enter an item title....');
            } else {
              // Store edited values in passed in item.
              widget.item.title = editItem.title;
              widget.item.desc = editItem.desc;
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _detailsBody() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(children: [
          Text(AppLocalizations.of(context)!.itemTitleLabel),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: _titleController,
                onChanged: (value) {
                  editItem.title = value;
                  changed = true;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.itemTitleHint,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Item Description'), // TODO: Localization.
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: _descController,
                maxLines: 16,
                onChanged: (value) {
                  editItem.desc = value;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.itemDescHint,
                ),
              ),
            ),
          ),
          // TODO: rework to do direct rather than cached images, since we will be storing or clouding them in base64 string encoding?
          //if (widget.item.image != null) const SizedBox(height: 24),
          //if (widget.item.image != null) CachedNetworkImage(imageUrl: widget.item.image.),
        ]),
      ),
    );
  }
}

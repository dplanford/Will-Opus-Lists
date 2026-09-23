import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/helper/willopus_snackbar_helper.dart';
import 'package:willopuslists/helper/willopus_list_helper.dart';
import 'package:willopuslists/services/willopus_list_item_services.dart';

// Auto-generated.
import 'package:willopuslists/l10n/app_localizations.dart';

/// Screen for displaying/adding a list item.
class WillOpusListItemDetailsScreen extends StatefulWidget {
  final WillOpusListItem item;
  final void Function()? refreshParent;

  const WillOpusListItemDetailsScreen({
    super.key,
    required this.item,
    this.refreshParent,
  });

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
    String appbarTitle = AppLocalizations.of(context)!.baseError;
    if (widget.item.id == null || widget.item.id!.isEmpty) {
      appbarTitle = AppLocalizations.of(context)!.screenTitleAddItem;
    } else {
      appbarTitle = AppLocalizations.of(context)!.screenTitleEditItem;
    }

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
                String? addedId = await WillOpusListItemServices.addItem(widget.item);
                if (addedId != null) {
                  WillOpusListHelper.itemsList.insert(0, widget.item);
                  WillOpusListHelper.updateSortIndexes();
                  snackBarText = AppLocalizations.of(context)!.snackbarItemAdded;
                  doExit = true;
                } else {
                  snackBarText = AppLocalizations.of(context)!.snackbarItemAddFailed;
                }
              } else {
                if (await WillOpusListItemServices.patchItem(widget.item)) {
                  snackBarText = AppLocalizations.of(context)!.snackbarItemUpdated;
                  doExit = true;
                } else {
                  snackBarText = AppLocalizations.of(context)!.snackbarItemUpdateFailed;
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
            Text(AppLocalizations.of(context)!.itemTitleLabel),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    widget.item.title = value;
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
      ),
    );
  }

  void _showSnackbar(String txt) {
    WillOpusSnackbarHelper.showSnackBar(context, txt);
  }

  void _exitScreen() {
    Navigator.of(context).pop();
  }
}

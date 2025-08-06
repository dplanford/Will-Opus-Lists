import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/services/willopus_list_services.dart';
import 'package:willopuslists/widgets/adaptive_alert_dialog.dart';
import 'package:willopuslists/screens/willopus_list_item_details_screen.dart';

class WillOpusListTile extends StatefulWidget {
  final WillOpusListItem item;
  final void Function()? refreshParent;

  const WillOpusListTile({super.key, required this.item, this.refreshParent});

  @override
  State<WillOpusListTile> createState() => _WillOpusListTileState();
}

class _WillOpusListTileState extends State<WillOpusListTile> {
  @override
  Widget build(BuildContext context) {
    double tableWidth = MediaQuery.of(context).size.width - 24;
    return Container(
      width: tableWidth,
      color: widget.item.isDone ? Theme.of(context).primaryColor : Colors.white,
      margin: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // TODO: rework this to not use cached images, but instead json encoded base64 images (see WillOpusImage class & Helper)
          if (widget.item.image != null)
            if (widget.item.image != null)
              CachedNetworkImage(
                imageUrl: widget.item.image!.imageBase64,
                fit: BoxFit.fill,
                width: 64.0,
                height: 64.0,
              ),
          if (widget.item.image != null) const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: TextStyle(fontSize: 20.0, color: widget.item.isDone ? Colors.white : Colors.black),
                  softWrap: true,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.item.desc,
                  style: TextStyle(fontSize: 12.0, color: widget.item.isDone ? Colors.white : Colors.black),
                  softWrap: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Column(
            children: [
              Checkbox(
                value: widget.item.isDone,
                onChanged: (newValue) {
                  setState(() {
                    widget.item.isDone = newValue ?? false;
                  });
                  WillOpusListServices.patchItem(widget.item);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  if (widget.item.isDone) {
                    // item tagged as completed, directly delete it.
                    await WillOpusListServices.deleteItem(widget.item);
                    if (widget.refreshParent != null) {
                      widget.refreshParent!();
                    }
                  } else {
                    // not completed, make sure the user wants to delete it.
                    bool delete = await _showDeleteItemDialog();
                    if (delete) {
                      await WillOpusListServices.deleteItem(widget.item);
                      if (widget.refreshParent != null) {
                        widget.refreshParent!();
                      }
                    }
                  }
                },
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WillOpusListItemDetailsScreen(item: widget.item, refreshParent: widget.refreshParent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteItemDialog() async {
    bool doDelete = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AdaptiveAlertDialog(
          title: const Text('Delete This Item?'),
          content: Text('Delete ${widget.item.title}?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                doDelete = false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
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

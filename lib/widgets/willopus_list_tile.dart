import 'package:flutter/material.dart';
import 'package:willopuslists/helper/willopus_color_helper.dart';

import 'package:willopuslists/model/willopus_list.dart';

class WillOpusListTile extends StatefulWidget {
  final WillOpusList list;
  final void Function()? refreshParent;

  const WillOpusListTile({super.key, required this.list, this.refreshParent});

  @override
  State<WillOpusListTile> createState() => _WillOpusListTileState();
}

class _WillOpusListTileState extends State<WillOpusListTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: Build a list tile with:
    // Column of:
    //  - top bar is a color bar set by the list's hex-color.
    //  - next is the list's title (larger text)
    //  - then list's description (smaller text)
    //
    //  - left icon (pencil edit icon) for poping up the edit list dialog
    //    - same as the current add new list dialog for now, with different service calls (add/patch, etc.)
    //    - need to eventually add delete list (trash can icon on list tile), with "are you sure" dialog.
    //
    // Whole tile is wrapped in a tap gesture (with tile icons overlayed/overridding the general tap)
    //  - general tap on list tile goes to that list's display screen....
    //
    //return Container();
    double tableWidth = MediaQuery.of(context).size.width - 24;
    return Container(
      width: tableWidth,
      //color: widget.item.isCompleted ? Theme.of(context).primaryColor : Colors.white,
      margin: const EdgeInsets.all(12.0),
      // TODO: Trying TextButton as a widget wrapper with a simple onPressed tap behavior....
      //  - might not be ideal for a list tile object?
      //  - MUST TEST overlay buttons on this tile! (edit/delete)....
      child: TextButton(
        onPressed: () {
          // TODO: Go to this individual list's screen....
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32.0,
                    child: Container(color: WillOpusColorHelper.colorFromHex(widget.list.hexColor)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.list.title,
                    //style: TextStyle(fontSize: 20.0, color: widget.list.isCompleted ? Colors.white : Colors.black),
                    softWrap: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.list.desc,
                    //style: TextStyle(fontSize: 12.0, color: widget.item.isCompleted ? Colors.white : Colors.black),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    // TODO: popup to edit list dialog, and save any edits....
                    // Should be same as add new list dialog, with slightly different hooks....
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // TODO: popup "are you sure" dialog before deleting this list and all it's sub-items?
                    // Need new delete entire list helper func?
                    //  - delete all sub-items, then delete main list?
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

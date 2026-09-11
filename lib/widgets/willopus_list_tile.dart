import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_master_list.dart';

class WillOpusListTile extends StatefulWidget {
  final WillOpusMasterList masterList;
  final void Function()? refreshParent;

  const WillOpusListTile({super.key, required this.masterList, this.refreshParent});

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
    return Container();
  }
}

/// The master (root) list object of all the user's sub-lists...
///
/// NOTE: Only one of these objects should exist for a single user of this app.
///
class WillOpusMasterList {
  final String _kID = 'id';
  final String _kListsIds = 'lists_ids';

  String? id;
  List<String> listsIds = [];

  WillOpusMasterList();

  WillOpusMasterList.fromJson(Map<String, dynamic> json) {
    id = json[_kID];
    if (json[_kListsIds] != null) {
      json[_kListsIds].forEach((v) {
        listsIds.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data[_kID] = id;
    data[_kListsIds] = listsIds;
    return data;
  }
}

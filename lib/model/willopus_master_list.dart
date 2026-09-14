/// The master (root) list object of all the user's sub-lists...
/// NOTE: Only one of these objects should exist for a single user of this app.
class WillOpusMasterList {
  String? id;
  List<String> listsIds = [];

  WillOpusMasterList({
    listsIds = const [],
  });

  WillOpusMasterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['lists_ids'] != null) {
      json['lists_ids'].forEach((v) {
        listsIds.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['lists_ids'] = listsIds;
    return data;
  }
}

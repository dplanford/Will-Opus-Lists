class WillOpusList {
  String? id;
  String title = '';
  // Color listColor = <default color>;
  List<String> itemKeys = [];

  WillOpusList({
    this.title = '',
    // this.color = <default color>,
    this.itemKeys = const [],
  });

  WillOpusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    if (json['item_keys'] != null) {
      json['item_keys'].forEach((v) {
        itemKeys.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['item_keys'] = itemKeys;
    return data;
  }
}

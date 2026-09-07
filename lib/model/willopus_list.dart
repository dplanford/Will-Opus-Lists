import 'package:willopuslists/constants.dart';

/// A list of items, with a title & color.
class WillOpusList {
  String? id;
  String title = '';
  String desc = '';
  String hexColor = kDefaultListColorHex;
  List<String> itemIds = [];

  WillOpusList({
    this.title = '',
    this.desc = '',
    this.hexColor = kDefaultListColorHex,
    this.itemIds = const [],
  });

  WillOpusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    desc = json['desc'] ?? '';
    hexColor = json['hex_color'];
    if (json['item_ids'] != null) {
      json['item_ids'].forEach((v) {
        itemIds.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['hex_color'] = hexColor;
    data['item_ids'] = itemIds;
    return data;
  }
}

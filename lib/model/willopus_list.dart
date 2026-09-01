import 'package:willopuslists/constants.dart';

class WillOpusList {
  String? id;
  String title = '';
  String hexColor = kDefaultListColorHex;
  List<String> itemIds = [];

  WillOpusList({
    this.title = '',
    this.hexColor = kDefaultListColorHex,
    this.itemIds = const [],
  });

  WillOpusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
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
    data['hex_color'] = hexColor;
    data['item_ids'] = itemIds;
    return data;
  }
}

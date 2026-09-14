import 'package:willopuslists/constants.dart';

/// A list of items, with a title & color.
class WillOpusList {
  static String _kID = 'id';
  static String _kTitle = 'title';
  static String _kDesc = 'desc';
  static String _kHexColor = 'hex_color';
  static String _kItemIds = 'item_ids';

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
    id = json[_kID];
    title = json[_kTitle] ?? '';
    desc = json[_kDesc] ?? '';
    hexColor = json[_kHexColor];
    if (json[_kItemIds] != null) {
      json[_kItemIds].forEach((v) {
        itemIds.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data[_kID] = id;
    data[_kTitle] = title;
    data[_kDesc] = desc;
    data[_kHexColor] = hexColor;
    data[_kItemIds] = itemIds;
    return data;
  }
}

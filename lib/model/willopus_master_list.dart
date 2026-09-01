import 'package:willopuslists/model/willopus_list_item.dart';

class WillOpusMasterList {
  String? id;
  List<WillOpusListItem> lists = [];

  WillOpusMasterList({
    lists = const [],
  });

  WillOpusMasterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['itemsList'] != null) {
      json['members'].forEach((v) {
        lists.add(WillOpusListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (lists.isNotEmpty) {
      data['itemsList'] = lists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

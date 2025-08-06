import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/constants.dart';

class WillOpusList {
  String? id;
  String title = '';
  Color bkgColor = kMrowlSomewhatLiteGreen;
  List<WillOpusListItem> items = [];
  int curIndex = 0;

  WillOpusList({
    this.title = '',
    this.curIndex = 0,
    this.bkgColor = kMrowlSomewhatLiteGreen,
    items = const [],
  });

  WillOpusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    curIndex = json['index'] ?? 0;
    bkgColor = json['bkgColor'] ?? kMrowlSomewhatLiteGreen;
    if (json['itemsList'] != null) {
      json['members'].forEach((v) {
        items.add(WillOpusListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // NOTE: Do not send the id... it is generated and only grabbed.
    data['title'] = title;
    data['index'] = curIndex;
    if (items.isNotEmpty) {
      data['itemsList'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

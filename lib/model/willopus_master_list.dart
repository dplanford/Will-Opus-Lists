import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/constants.dart';

class WillOpusMasterList {
  String? id;
  String title = '';
  Color bkgColor = kMrowlSomewhatLiteGreen;
  List<WillOpusListItem> items = [];
  int curIndex = 0;

  WillOpusMasterList({
    this.title = '',
    this.curIndex = 0,
    this.bkgColor = kMrowlSomewhatLiteGreen,
    items = const [],
  });

  WillOpusMasterList.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['title'] = title;
    data['index'] = curIndex;
    if (items.isNotEmpty) {
      data['itemsList'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

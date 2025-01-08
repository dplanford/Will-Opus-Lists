import 'package:flutter/material.dart';

import 'package:willopuslists/model/willopus_list_item.dart';
import 'package:willopuslists/constants.dart';

class WillOpusList {
  String? id;
  String title = '';
  Color bkgColor = kMrowlPrimaryGreen;
  Color txtColor = Colors.black;
  List<WillOpusListItem> listItems = [];

  WillOpusList({
    this.id,
    this.title = '',
    this.bkgColor = kMrowlPrimaryGreen,
    this.txtColor = Colors.black,
    this.listItems = const [],
  });

  WillOpusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    int bkgColorInt = json['bkgColor'] ?? 0;
    bkgColor = Color(bkgColorInt);
    int txtColorInt = json['txtColor'] ?? 0;
    txtColor = Color(txtColorInt);
    // TODO: grab list items id(by key) list!
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // NOTE: Do not send the id... it is generated and only grabbed.
    data['title'] = title;
    data['bkgColor'] = bkgColor.value;
    data['txtColor'] = txtColor.value;
    // TODO: convert list items list to id(key) list!
    return data;
  }
}

import 'package:willopuslists/model/willopus_image.dart';

class WillOpusListItem {
  String? id;
  String title = '';
  String desc = '';
  WillOpusImage? image;
  int curIndex = 0;
  bool isDone = false;

  WillOpusListItem({this.title = '', this.desc = '', this.image, this.curIndex = 0, this.isDone = false});

  WillOpusListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    desc = json['desc'] ?? '';
    image = WillOpusImage().fromJson(json['image']) ?? null;
    curIndex = json['index'] ?? 0;
    isDone = json['done'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['image'] = image != null ? image!.toJson() : null;
    data['index'] = curIndex;
    data['done'] = isDone;
    return data;
  }
}

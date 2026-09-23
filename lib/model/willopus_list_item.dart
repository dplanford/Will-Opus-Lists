/// An individual item in a list.
class WillOpusListItem {
  static String _kID = 'id';
  static String _kTitle = 'title';
  static String _kDesc = 'desc';
  static String _kCompleted = 'done';

  String? id;
  String title = '';
  String desc = '';
  //WillOpusImage? image;
  bool isCompleted = false;

  WillOpusListItem({
    this.title = '',
    this.desc = '',
    //this.image,
    this.isCompleted = false,
  });

  WillOpusListItem.fromJson(Map<String, dynamic> json) {
    id = json[_kID];
    title = json[_kTitle] ?? '';
    desc = json[_kDesc] ?? '';
    isCompleted = json[_kCompleted] ?? false;
    //image = null; //WillOpusImage().fromJson(json['image']) ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data[_kID] = id;
    data[_kTitle] = title;
    data[_kDesc] = desc;
    data[_kCompleted] = isCompleted;
    //data['image'] = image != null ? image!.toJson() : null;
    return data;
  }
}

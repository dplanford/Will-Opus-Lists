/// An individual item in a list
class WillOpusListItem {
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
    id = json['id'];
    title = json['title'] ?? '';
    desc = json['desc'] ?? '';
    //image = null; //TODO: WillOpusImage().fromJson(json['image']) ?? null;
    isCompleted = json['done'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    //data['image'] = image != null ? image!.toJson() : null;
    data['done'] = isCompleted;
    return data;
  }
}

class WillOpusListItem {
  String? id;
  String parentListId = '';
  String title = '';
  String desc = '';
  String imagePath = '';
  int curIndex = 0;
  bool isDone = false;

  WillOpusListItem({
    required this.parentListId,
    this.title = '',
    this.desc = '',
    this.imagePath = '',
    this.curIndex = 0,
    this.isDone = false,
  });

  WillOpusListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentListId = json['parentListId'] ?? '';
    title = json['title'] ?? '';
    desc = json['desc'] ?? '';
    imagePath = json['image_path'] ?? false;
    curIndex = json['index'] ?? 0;
    isDone = json['done'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // NOTE: Do not send the id... it is generated and only grabbed.
    data['parentListId'] = parentListId;
    data['title'] = title;
    data['desc'] = desc;
    data['image_path'] = imagePath;
    data['index'] = curIndex;
    data['done'] = isDone;
    return data;
  }
}

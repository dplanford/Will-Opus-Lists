class WillOpusImage {
  String? id;
  String imageBase64 = '';

  WillOpusImage({
    this.id = '',
    this.imageBase64 = '',
  });

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageBase64 = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['image'] = imageBase64;
    return data;
  }
}

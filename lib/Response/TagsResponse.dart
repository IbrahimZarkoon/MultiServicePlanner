class TagsResponse {
  String? id;
  String? tag;

  TagsResponse({this.id, this.tag});

  TagsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    return data;
  }
}

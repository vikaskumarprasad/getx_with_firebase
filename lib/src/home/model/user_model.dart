class UserModel {
  UserModel({
    this.name,
    this.description,
    this.title,
  });

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    title = json['title'];
  }
  String? name;
  String? description;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['title'] = title;
    return map;
  }
}

class CategoryModel {
  String? name;
  String? image;

  CategoryModel({
    this.name,
    this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['image'] = image;
    return json;
  }
}
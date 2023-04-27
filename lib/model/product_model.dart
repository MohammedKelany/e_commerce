class ProductModel {
  String? name;
  String? image;
  String? productId;
  String? brand;
  String? size;
  String? description;
  String? color;
  String? price;

  ProductModel({
    this.name,
    this.image,
    this.productId,
    this.brand,
    this.size,
    this.description,
    this.color,
    this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    image = json['image'] as String?;
    productId = json['productId'] as String?;
    brand = json['brand'] as String?;
    size = json['size'] as String?;
    description = json['description'] as String?;
    color = json['color'] as String?;
    price = json['price'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['image'] = image;
    json['productId'] = productId;
    json['brand'] = brand;
    json['size'] = size;
    json['description'] = description;
    json['color'] = color;
    json['price'] = price;
    return json;
  }
}

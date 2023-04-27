class CartProductModel {
  int? id;
  String? productId;
  String? name;
  String? image;
  String? price;
  int? quantity;

  CartProductModel({
    this.id,
    this.productId,
    this.name,
    this.image,
    this.quantity,
    this.price,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    productId = json['productId'] as String?;
    image = json['image'] as String?;
    quantity = json['quantity'];
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['productId'] = productId;
    json['name'] = name;
    json['image'] = image;
    json['quantity'] = quantity;
    json['price'] = price;
    return json;
  }
}

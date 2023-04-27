class OrderModel {
  String? time;
  String? status;
  List<OrderProducts>? orderProducts;
  Location? location;

  OrderModel({
    this.time,
    this.status,
    this.orderProducts,
    this.location,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    time = json['time'] as String?;
    status = json['status'] as String?;
    orderProducts = (json['orderProducts'] as List?)
        ?.map((dynamic e) => OrderProducts.fromJson(e as Map<String, dynamic>))
        .toList();
    location = (json['location'] as Map<String, dynamic>?) != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['time'] = time;
    json['status'] = status;
    json['orderProducts'] = orderProducts?.map((e) => e.toJson()).toList();
    json['location'] = location?.toJson();
    return json;
  }
}

class OrderProducts {
  int? quantity;
  String? productId;
  String? name;
  String? image;
  String? price;

  OrderProducts({
    this.productId,
    this.name,
    this.image,
    this.price,
    this.quantity,
  });

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] as String?;
    name = json['name'] as String?;
    image = json['image'] as String?;
    price = json['price'].toString();
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['productId'] = productId;
    json['name'] = name;
    json['image'] = image;
    json['quantity'] = quantity;
    json['price'] = price;
    return json;
  }
}

class Location {
  String? street1;
  String? street2;
  String? state;
  String? country;
  String? city;

  Location({
    this.street1,
    this.street2,
    this.state,
    this.country,
    this.city,
  });

  Location.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'] as String?;
    street2 = json['street2'] as String?;
    state = json['state'] as String?;
    country = json['country'] as String?;
    city = json['city'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['street1'] = street1;
    json['street2'] = street2;
    json['state'] = state;
    json['country'] = country;
    json['city'] = city;
    return json;
  }
}

import 'dart:convert';

class Product {
  bool available;
  String name;
  Map<String, dynamic>? picture;
  double price;
  String? id;
  String category;
  String? description;
  int? stock;

  Product({
    this.description,
    this.stock,
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id,
    required this.category,
  });

  factory Product.fromRawJson(String str) =>
      Product.fromJson(json.decode(str), picture: []);

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json,
          {required List<String> picture}) =>
      Product(
        available: json["available"],
        name: json["name"],
        id: json["id"],
        picture:
            Map<String, dynamic>.from(json["picture"] as Map<String, dynamic>),
        price: json["price"].toDouble(),
        category: json["category"],
        description: json["description"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "id": id,
        "picture": picture,
        "price": price,
        "category": category,
        "description": description,
        "stock": stock,
      };

  Product copy() => Product(
        available: available,
        name: name,
        price: price,
        picture: picture,
        id: id,
        category: category,
        description: description,
        stock: stock,
      );
}

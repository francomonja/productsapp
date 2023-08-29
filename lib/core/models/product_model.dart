import 'dart:convert';

class Product {
  bool available;
  String name;
  String? picture;
  double price;
  String? id;
  String category;

  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id,
    required this.category,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
        "category": category,
      };

  Product copy() => Product(
        available: available,
        name: name,
        price: price,
        picture: picture,
        id: id,
        category: category,
      );
}

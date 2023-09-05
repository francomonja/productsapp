import 'dart:convert';

class Product {
  bool available;
  String name;
  double price;
  String? id;
  String category;
  String? description;
  int? stock;
  String? picture;
  String? picture2;
  String? picture3;

  Product({
    this.description,
    this.stock,
    required this.available,
    required this.name,
    this.picture,
    this.picture2,
    this.picture3,
    required this.price,
    this.id,
    required this.category,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        id: json["id"],
        price: json["price"].toDouble(),
        category: json["category"],
        description: json["description"],
        stock: json["stock"],
        picture: json["picture"],
        picture2: json["picture2"],
        picture3: json["picture3"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "id": id,
        "price": price,
        "category": category,
        "description": description,
        "stock": stock,
        "picture": picture,
        "picture2": picture2,
        "picture3": picture3,
      };

  Product copy() => Product(
        available: available,
        name: name,
        price: price,
        id: id,
        category: category,
        description: description,
        stock: stock,
        picture: picture,
        picture2: picture2,
        picture3: picture3,
      );
}

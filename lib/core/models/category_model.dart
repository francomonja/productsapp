import 'dart:convert';

class Category {
  String name;
  String? id;

  Category({
    required this.name,
    this.id,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };

  Category copy() => Category(
        name: name,
        id: id,
      );
}

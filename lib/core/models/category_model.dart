import 'dart:convert';

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Category copy() => Category(
        name: name,
      );
}

class ApiCategoriesResponse {}

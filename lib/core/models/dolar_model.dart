import 'dart:convert';

class Dolar {
  String price;

  Dolar({
    required this.price,
  });

  factory Dolar.fromRawJson(String str) => Dolar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dolar.fromJson(Map<String, dynamic> json) => Dolar(
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };

  Dolar copy() => Dolar(
        price: price,
      );
}

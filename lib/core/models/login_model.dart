import 'dart:convert';

class Login {
  String user;
  String password;

  Login({
    required this.user,
    required this.password,
  });

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        user: json["user"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "password": password,
      };

  Login copy() => Login(
        user: user,
        password: password,
      );
}

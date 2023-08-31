import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class CategoryService {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final storage = FlutterSecureStorage();

  // loadCategory() async {
  //   List<String> categoryList = [];
  //   final url = Uri.https(_baseUrl, 'category.json', {
  //     'auth': await storage.read(key: 'token') ?? '',
  //   });
  //   final resp = await http.get(url);
  //   var qsy = json.decode(resp.body);
  // }
}

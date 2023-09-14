import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import '../models/dolar_model.dart';

class DolarService {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final storage = FlutterSecureStorage();

  Map<String, dynamic> listDolar = {'price': ''};

  Future<Map<String, dynamic>> loadDolar() async {
    Map<String, dynamic> dolarList = {'price': ''};
    final url = Uri.https(_baseUrl, 'dolar.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> dolarMap = jsonDecode(resp.body);
      dolarList['price'] = dolarMap["price"];
    } catch (error) {
      print('Error: $error');
    }
    listDolar = dolarList;
    print(dolarList);
    return dolarList;
  }

  Future updateDolar(Dolar dolar) async {
    final url = Uri.https(_baseUrl, 'dolar.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    await http.put(url, body: dolar.toRawJson());
    return dolar.price;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CartService {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final storage = FlutterSecureStorage();

  void showCustomSnackbar(BuildContext context, e) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: Text(e),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future saveCart(Map<String, String> shopCart, BuildContext context) async {
    String cart = json.encode(shopCart);
    try {
      final url = Uri.https(_baseUrl, 'cart.json');
      final response = await http.put(url, body: cart);
      if (response.statusCode == 200) {
        showCustomSnackbar(context, 'Carrito guardado');
        print('El carrito se ha guardado exitosamente.');
      } else {
        showCustomSnackbar(context,
            'Error al guardar el carrito. Código de estado: ${response.statusCode}');
        print(
            'Error al guardar el carrito. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return shopCart;
  }

  Future<Map<String, dynamic>> loadCart() async {
    Map<String, dynamic> tempCart = {};
    final url = Uri.https(_baseUrl, 'cart.json');
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> cartMap = json.decode(resp.body);
      tempCart = cartMap;
    } catch (error) {
      print('Error: $error');
    }
    return tempCart;
  }
}

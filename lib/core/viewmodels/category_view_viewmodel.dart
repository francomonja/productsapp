import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_app/app.locator.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/models/product_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class CategoryViewViewModel extends ChangeNotifier {
  final _navigationService = locator<NavigationService>();
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  bool isLoading = false;
  final List<Product> products = [];

  List<Product> productList = [];

  void findByCategory(String value) {
    productList.clear();
    productList =
        products.where((element) => element.category.contains(value)).toList();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    products.clear();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  void onPressCamping() async {
    await loadProducts();
    findByCategory('camping');
    await _navigationService.navigateToHomeView(products: productList);
  }

  void onPressVasos() async {
    await loadProducts();
    findByCategory('vasos');
    await _navigationService.navigateToHomeView(products: productList);
  }

  void onPressVarios() async {
    await loadProducts();
    findByCategory('varios');
    await _navigationService.navigateToHomeView(products: productList);
  }

  void onPressCocina() async {
    await loadProducts();
    findByCategory('cocina');
    await _navigationService.navigateToHomeView(products: productList);
  }
}

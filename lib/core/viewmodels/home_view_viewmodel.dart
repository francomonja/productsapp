import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';
import 'package:http/http.dart' as http;

class HomeViewViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final productsService = locator<ProductsService>();
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  // List<Product> products = [];
  List<Product> productList = [];
  final storage = FlutterSecureStorage();
  // Product? selectedProduct;
  bool isLoading = false;
  bool isSaving = false;

  // findByCategory(String salectedCategory) async {
  //   productList = products
  //       .where((element) => element.category.contains(salectedCategory))
  //       .toList();
  //   return productList;
  // }

  init(selectedCategory) async {
    await productsService.loadProducts();
    productList = await findByCategory(selectedCategory);
    notifyListeners();
    return productList;
  }

  onRefresh(selectedCategory) async {
    init(selectedCategory);
  }

  findByCategory(String selectedCategory) async {
    productList.clear();
    productList = productsService.products
        .where((element) => element.category.contains(selectedCategory))
        .toList();
    return productList;
  }
  // Future<List<Product>> loadProducts() async {
  //   isLoading = true;
  //   final url = Uri.https(_baseUrl, 'products.json');
  //   final resp = await http.get(url);

  //   final Map<String, dynamic> productsMap = json.decode(resp.body);
  //   productsMap.forEach((key, value) {
  //     final tempProduct = Product.fromJson(value);
  //     tempProduct.id = key;
  //     products.add(tempProduct);
  //   });

  //   isLoading = false;
  //   print(products);
  //   notifyListeners();
  //   return products;
  // }

  void onTapProduct(id) async {
    final url = Uri.https(_baseUrl, 'products/${id}.json');
    final resp = await http.get(url);
    Map<String, dynamic> jsonMap = json.decode(resp.body);
    productsService.selectedProduct = Product.fromJson(jsonMap);
    navigateToProductView();
  }

  void navigateToProductView() async {
    await _navigationService.navigateToProductView(
        productsService: productsService);
  }

  void onDelete(index, selectedCategory) async {
    await productsService.onDelete(index);

    await onRefresh(selectedCategory);
    notifyListeners();
  }
}

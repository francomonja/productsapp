import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';
import 'package:http/http.dart' as http;

class HomeViewViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final productsService = locator<ProductsService>();
  final categoryService = locator<CategoryService>();
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  List<Product> products = [];
  List<Product> productList = [];
  final storage = FlutterSecureStorage();
  bool isLoading = false;
  bool isSaving = false;

  final TextEditingController search = TextEditingController();

  Category selectedCategory = Category(name: 'Todas las categorias');
  List<Category> categoryList = [];

  findByCategory() async {
    if (selectedCategory.name == 'Todas las categorias') {
      productList = products;
    } else {
      productList = products
          .where((element) => element.category
              .toLowerCase()
              .contains(selectedCategory.name.toLowerCase()))
          .toList();
    }
    if (search.text.isNotEmpty) {
      productList = productList
          .where((element) =>
              element.name.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> init() async {
    categoryList = await categoryService.loadCategory();
    products = await productsService.loadProducts();
    productList = products;

    notifyListeners();
  }

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

  void navigateToCategoryView() async {
    await _navigationService.navigateToCategoryView(
        categoryService: categoryService);
  }

  void onDelete(id) async {
    await productsService.onDelete(id);
    productList.removeWhere((element) => element.id == id);
    products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void onChangeCategory(value) {
    selectedCategory = value;
    findByCategory();
    notifyListeners();
  }

  Future<void> deleteCategory(id) async {
    await categoryService.onDelete(id);
    notifyListeners();
  }
}

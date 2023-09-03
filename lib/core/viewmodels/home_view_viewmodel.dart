import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/menu_items/menu_items.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../enums/dialog_type.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';
import 'package:http/http.dart' as http;

class HomeViewViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final productsService = locator<ProductsService>();
  final categoryService = locator<CategoryService>();

  final CategoryService _categoryService = locator<CategoryService>();
  final TextEditingController categoryController = TextEditingController();
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  List<Product> products = [];
  List<Product> productList = [];
  final storage = FlutterSecureStorage();
  bool isLoading = false;
  bool isSaving = false;
  int navDrawerIndex = 0;

  final DialogService _dialogService = locator<DialogService>();

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

  void navigateToDeleteCategoryView() async {
    await _navigationService.navigateToDeleteCategoryView();
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

  void selectedOption(value) async {
    final menuItem = appMenuItems[value];
    navDrawerIndex = value;
    notifyListeners();
    switch (menuItem.link) {
      case 'product-view':
        navigateToProductView();
        productsService.selectedProduct = Product(
          available: false,
          name: '',
          price: 0,
          category: '',
        );
        break;
      case 'category-view':
        dialog();
        break;
      case 'delete-view':
        navigateToDeleteCategoryView();
        break;
    }
  }

  void dialog() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.categoryForm,
      title: 'Ingrese la categoría',
    );
    if (response!.confirmed) {
      Category newCategory = response.data;
      await _categoryService.createCategory(newCategory);
      init();
    }
  }
}

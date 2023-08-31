import 'dart:convert';

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
  // Product? selectedProduct;
  bool isLoading = false;
  bool isSaving = false;

  Category selectedCategory = Category(name: 'Todas las categorias');
  final List<Category> categoryList = [
    Category(name: 'Todas las categorias'),
    Category(name: 'Camping'),
    Category(name: 'Vasos'),
    Category(name: 'Varios'),
    Category(name: 'Cocina'),
  ];

  findByCategory(String selectedCategory) async {
    if (selectedCategory == 'Todas las categorias') {
      productList = products;
    } else {
      productList = products.where((element) => element.category.toLowerCase().contains(selectedCategory.toLowerCase())).toList();
    }
    notifyListeners();
  }

  Future<void> init() async {
    products = await productsService.loadProducts();
    productList = products;
    // await categoryService.loadCategory();
    notifyListeners();
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
    await _navigationService.navigateToProductView(productsService: productsService);
  }

  void onDelete(id) async {
    await productsService.onDelete(id);
    productList.removeWhere((element) => element.id == id);
    products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void onChangeCategory(value) {
    selectedCategory = value;
    findByCategory(selectedCategory.name);
    notifyListeners();
  }
}

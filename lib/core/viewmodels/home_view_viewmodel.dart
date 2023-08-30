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
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  final storage = FlutterSecureStorage();
  Product? selectedProduct;
  bool isLoading = true;
  bool isSaving = false;

  final productsService = locator<ProductsService>();

  void onRefresh() {}

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

  void navigateToProductView() async {
    await _navigationService.navigateToProductView(
        productsService: productsService);
  }

  void onDelete(index) async {
    await loadProducts();

    try {
      final url = Uri.https(_baseUrl, 'products/${products[index].id}.json');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting product: $error');
    }
    products.removeAt(index);
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

import '../../app.locator.dart';
import '../models/product_model.dart';

// enum Categoria { camping, cocina, vasos, varios }

class ProductViewViewModel extends ChangeNotifier {
  // final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final ProductsService productsService = locator<ProductsService>();
  final CategoryService categoryService = locator<CategoryService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController stockController = TextEditingController();
  TextEditingController stockRosarioController = TextEditingController();
  File? newPictureFile;
  List<Category> categoryList = [];
  String selectedCategory = 'Todas las categorias';
  bool isSaving = false;

  Future<void> init() async {
    categoryList = await categoryService.loadCategory();
    stockController.text = (productsService.selectedProduct!.stock != null)
        ? productsService.selectedProduct!.stock.toString()
        : '0';
    stockRosarioController.text =
        (productsService.selectedProduct!.stockRosario != null)
            ? productsService.selectedProduct!.stock.toString()
            : '0';
    productsService.selectedProduct!.stock = int.parse(stockController.text);
    selectedCategory = (productsService.selectedProduct!.category);
    notifyListeners();
  }

  change(value) {
    selectedCategory = value;
    productsService.selectedProduct!.category = value;
    notifyListeners();
  }

  void updateAvailability(bool value) {
    productsService.selectedProduct!.available =
        !productsService.selectedProduct!.available;
    notifyListeners();
  }

  void updateSelectedProductImage(String path, i) {
    productsService.updateSelectedProductImage(path, i);
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    await productsService.uploadImage();
    return null;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();
    if (productsService.selectedProduct!.stock == 0) {
      productsService.selectedProduct!.available = false;
    } else {
      productsService.selectedProduct!.available = true;
    }
    await productsService.saveOrCreateProduct(product);
    isSaving = false;
    notifyListeners();
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  void decrementStock(name) {
    if (name == 'Stock Oberá') {
      if (productsService.selectedProduct!.stock! > 0) {
        productsService.selectedProduct!.stock =
            productsService.selectedProduct!.stock! - 1;
        stockController.text =
            productsService.selectedProduct!.stock.toString();
        notifyListeners();
      }
    } else if (name == 'Stock Rosario') {
      if (productsService.selectedProduct!.stockRosario! > 0) {
        productsService.selectedProduct!.stockRosario =
            productsService.selectedProduct!.stockRosario! - 1;
        stockRosarioController.text =
            productsService.selectedProduct!.stockRosario.toString();
        notifyListeners();
      }
    }
  }

  void clearStock(name) {
    if (name == 'Stock Oberá') {
      productsService.selectedProduct!.stock = 0;
      stockController.text = productsService.selectedProduct!.stock.toString();
      notifyListeners();
    } else if (name == 'Stock Rosario') {
      productsService.selectedProduct!.stockRosario = 0;
      stockRosarioController.text =
          productsService.selectedProduct!.stockRosario.toString();
      notifyListeners();
    }
  }

  void incrementStock(name) {
    if (name == 'Stock Oberá') {
      productsService.selectedProduct!.stock =
          productsService.selectedProduct!.stock! + 1;
      stockController.text = productsService.selectedProduct!.stock.toString();
      notifyListeners();
    } else if (name == 'Stock Rosario') {
      productsService.selectedProduct!.stockRosario =
          productsService.selectedProduct!.stockRosario! + 1;
      stockRosarioController.text =
          productsService.selectedProduct!.stockRosario.toString();
      notifyListeners();
    }
  }

  orderList(Map<String, dynamic> picture, index) {
    // String deleteWord = 'picture';
    Map<String, dynamic> updatedMap = {};
    // String firstKey = picture.keys.first;
    // firstKey = firstKey.replaceAll(deleteWord, '');
    // int first = int.parse(firstKey);
    if (index > 0) {
      for (var i = 0; i < index; i++) {
        updatedMap['picture$i'] = picture['picture$i'];
      }
    }
    for (var i = index; i < picture.length; i++) {
      if (index == 0) {
        index = 1;
      }
      updatedMap['picture$i'] = picture['picture${index + i}'];
    }
    picture = updatedMap;
    return picture;
  }

  Future<void> deleteImage(Product product, index) async {
    try {
      isSaving = true;
      notifyListeners();
      product.picture!
          .removeWhere((key, value) => key.endsWith(index.toString()));
      product.picture = orderList(product.picture!, index);
      await productsService.saveOrCreateProduct(product);
      isSaving = false;
      notifyListeners();
      // final url =
      //     Uri.https(_baseUrl, 'products/${product.id}/picture/picture$index');
      // final response = await http.delete(url);

      //   if (response.statusCode == 200) {
      //     productsService.selectedProduct!.picture!
      //         .removeWhere((key, value) => key.endsWith(index));
      //     print('Product deleted successfully');
      //     notifyListeners();
      //   } else {
      //     print('Failed to delete product. Status code: ${response.statusCode}');
      //   }
    } catch (error) {
      print('Error deleting product: $error');
      isSaving = false;
      notifyListeners();
    }
  }
}

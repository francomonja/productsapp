import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:products_app/core/providers/product_form_provider.dart';

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
  String selectedCategory = 'ordenar';
  bool isSaving = false;

  Future<void> init() async {
    categoryList = await categoryService.loadCategory();
    stockController.text = (productsService.selectedProduct!.stock != null)
        ? productsService.selectedProduct!.stock.toString()
        : '0';
    stockRosarioController.text =
        (productsService.selectedProduct!.stockRosario != null)
            ? productsService.selectedProduct!.stockRosario.toString()
            : '0';
    productsService.selectedProduct!.stock = int.parse(stockController.text);
    productsService.selectedProduct!.stockRosario =
        int.parse(stockRosarioController.text);
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
    final productForm = ProductFormProvider(productsService.selectedProduct!);
    isSaving = true;
    notifyListeners();

    if (productForm.isValidForm()) return;
    final List<String?>? imageUrl = await productsService.uploadImage();
    final Map<String, dynamic> picture = productForm.product.picture ?? {};

    if (imageUrl != null) {
      for (int i = 0; i < imageUrl.length; i++) {
        picture['picture$i'] = imageUrl[i];
      }
      productForm.product.picture = picture;
    } else if (productsService.selectedProduct!.picture!.isEmpty) {
      picture['picture0'] =
          "https://res.cloudinary.com/dgagjc77g/image/upload/v1694473012/imagen-no-disponible_advark.jpg";
    }

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
    Map<String, dynamic> updatedMap = {};
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
    } catch (error) {
      print('Error deleting product: $error');
      isSaving = false;
      notifyListeners();
    }
  }
}

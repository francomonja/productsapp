import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../models/product_model.dart';

// enum Categoria { camping, cocina, vasos, varios }

class ProductViewViewModel extends ChangeNotifier {
  final productsService = locator<ProductsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  File? newPictureFile;

  String camping = 'camping';
  String cocina = 'cocina';
  String vasos = 'vasos';
  String varios = 'varios';
  String selectedCategory = 'varios';

  change(value) {
    selectedCategory = value;
    productsService.selectedProduct!.category = value;
    notifyListeners();
  }

  void updateAvailability(bool value) {
    productsService.selectedProduct!.available = !productsService.selectedProduct!.available;
    notifyListeners();
  }

  void updateSelectedProductImage(String path) {
    productsService.updateSelectedProductImage(path);
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    await productsService.uploadImage();
    return null;
  }

  Future saveOrCreateProduct(Product product) async {
    await productsService.saveOrCreateProduct(product);
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/providers/product_form_provider.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';

class ProductViewViewModel extends ChangeNotifier {
  final productsService = locator<ProductsService>();
  final _navigationService = locator<NavigationService>();
  File? newPictureFile;

  void navigateToHomeView() async {
    await _navigationService.replaceWithHomeView();
  }

  void updateAvailability(bool value) {
    productsService.selectedProduct!.available =
        !productsService.selectedProduct!.available;
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
}

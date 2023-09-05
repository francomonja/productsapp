import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:products_app/ui/widgets/product_image.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../models/product_model.dart';

// enum Categoria { camping, cocina, vasos, varios }

class ProductViewViewModel extends ChangeNotifier {
  final ProductsService productsService = locator<ProductsService>();
  final CategoryService categoryService = locator<CategoryService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController stockController = TextEditingController();
  File? newPictureFile;
  List<Category> categoryList = [];
  String selectedCategory = 'Todas las categorias';
  late int currentIndex;

  Future<void> init() async {
    categoryList = await categoryService.loadCategory();
    stockController.text = (productsService.selectedProduct!.stock != null)
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

  void updateSelectedProductImage(String path) {
    productsService.updateSelectedProductImage(path, currentIndex);
    notifyListeners();
  }

  Future<String?> uploadImage(int index) async {
    await productsService.uploadImage();
    return null;
  }

  Future saveOrCreateProduct(Product product) async {
    if (productsService.selectedProduct!.stock == 0) {
      productsService.selectedProduct!.available = false;
    } else {
      productsService.selectedProduct!.available = true;
    }
    await productsService.saveOrCreateProduct(product);
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  void decrementStock() {
    if (productsService.selectedProduct!.stock! > 0) {
      productsService.selectedProduct!.stock =
          productsService.selectedProduct!.stock! - 1;
      stockController.text = productsService.selectedProduct!.stock.toString();
      notifyListeners();
    }
  }

  void clearStock() {
    productsService.selectedProduct!.stock = 0;
    stockController.text = productsService.selectedProduct!.stock.toString();
    notifyListeners();
  }

  void incrementStock() {
    productsService.selectedProduct!.stock =
        productsService.selectedProduct!.stock! + 1;
    stockController.text = productsService.selectedProduct!.stock.toString();
    notifyListeners();
  }

  showImage(index, product) {
    var image;
    switch (index) {
      case 0:
        image = ProductImage().getImage(product.picture);
        currentIndex = 0;
        print(currentIndex);
        // product.picture != null
        //     ? image = NetworkImage(product.picture)
        //     : image = const AssetImage('assets/no-image.png');
        break;
      case 1:
        currentIndex = 1;
        image = ProductImage().getImage(product.picture2);
        print(currentIndex);
        // product.picture2 != null
        //     ? image = NetworkImage(product.picture2)
        //     : image = const AssetImage('assets/no-image.png');
        break;
      case 2:
        currentIndex = 2;
        image = ProductImage().getImage(product.picture3);
        print(currentIndex);
        // product.picture3 != null
        //     ? image = NetworkImage(product.picture3)
        //     : image = const AssetImage('assets/no-image.png');
        break;
    }
    return image;
  }
}

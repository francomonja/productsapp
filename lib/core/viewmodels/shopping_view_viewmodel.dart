import 'package:flutter/material.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/services/cart_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../enums/dialog_type.dart';
import '../menu_items/menu_items_Shop.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';

class ShoppingViewViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController cartController = TextEditingController();
  final productsService = locator<ProductsService>();
  final cartService = locator<CartService>();
  final DialogService _dialogService = locator<DialogService>();
  List<Product> shopList = [];
  Map<String, String> shopCart = {};
  Map<String, String> orderCart = {};
  int navDrawerIndex = 0;

  Future<void> init() async {
    shopList = await productsService.loadProducts();
    await initCart();
    notifyListeners();
  }

  Future<Map<String, String>> initCart() async {
    shopList.forEach((element) {
      if (shopCart[element.name] == null) {
        shopCart[element.name] = "0";
      }
    });
    await loadCart();
    return shopCart;
  }

  Future<Map<String, String>> resetCart(BuildContext context) async {
    shopList.forEach((element) {
      shopCart[element.name] = "0";
    });
    await saveCart(context);
    return shopCart;
  }

  void decrementCart(name) {
    if (int.parse(shopCart[name]!) > 0) {
      shopCart[name] = (int.parse(shopCart[name]!) - 1).toString();
      notifyListeners();
    }
  }

  void increaseCart(name) {
    shopCart[name] = (int.parse(shopCart[name]!) + 1).toString();
    notifyListeners();
  }

  Future saveCart(BuildContext context) async {
    orderCart = {};
    shopCart.forEach((key, value) {
      if (int.parse(shopCart[key]!) > 0) {
        orderCart[key] = value;
      }
    });
    await cartService.saveCart(orderCart, context);
  }

  Future<Map<String, dynamic>> loadCart() async {
    Map<String, dynamic> tempCart = await cartService.loadCart();
    print(tempCart);
    tempCart.forEach((key, value) {
      if (shopCart.containsKey(key)) {
        shopCart[key] = value;
      }
    });
    return shopCart;
  }

  void navigateToProductView() async {
    await _navigationService.navigateToShopPreviewView(orderCart: orderCart);
  }

  void selectedOption(value, context) async {
    final menuItemShop = appMenuItemsShop[value];
    navDrawerIndex = value;
    notifyListeners();
    switch (menuItemShop.link) {
      case 'shop-recived':
        dialogConfirmation(context);
        break;
      case 'shop-preview':
        navigateToProductView();
        break;
      case 'shop-clear':
        resetCart(context);
        break;
    }
  }

  void dialogConfirmation(context) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmation,
      title: '¿Confirmar que el pedido llegó?',
    );
    if (response!.confirmed) {
      await saveCart(context);
      await changeStock(orderCart);
      resetCart(context);
      notifyListeners();
      print('confirmado');
    }
  }

  changeStock(Map<String, String> orderCart) async {
    List<Product> addProducts = [];
    for (var i = 0; i < orderCart.length; i++) {
      final List<MapEntry<String, String>> entries = orderCart.entries.toList();
      final MapEntry<String, String> entry = entries[i];
      final String clave = entry.key;
      final String valor = entry.value;
      shopList.where((element) {
        if (element.name == clave) {
          if (element.stock! < int.parse(valor)) {
            element.stock = 0;
            element.stockRosario = element.stockRosario! + int.parse(valor);
            addProducts.add(element);
          } else {
            element.stock = element.stock! - int.parse(valor);
            element.stockRosario = element.stockRosario! + int.parse(valor);
            addProducts.add(element);
          }
        }
        return true;
      }).toList();
    }

    await saveProducts(addProducts);
    return addProducts;
  }

  saveProducts(List<Product> addProducts) {
    addProducts.forEach((element) async {
      await productsService.saveOrCreateProduct(element);
    });
  }
}

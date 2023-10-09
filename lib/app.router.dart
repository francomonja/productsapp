// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i9;
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:products_app/core/services/products_service.dart' as _i10;
import 'package:products_app/ui/views/delete_category_view.dart' as _i6;
import 'package:products_app/ui/views/home_view.dart' as _i2;
import 'package:products_app/ui/views/product_description_view.dart' as _i5;
import 'package:products_app/ui/views/product_view.dart' as _i4;
import 'package:products_app/ui/views/shop_preview_view.dart' as _i7;
import 'package:products_app/ui/views/shopping_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const homeView = '/home-view';

  static const shoppingView = '/shopping-view';

  static const productView = '/product-view';

  static const productDescriptionView = '/product-description-view';

  static const deleteCategoryView = '/delete-category-view';

  static const shopPreviewView = '/shop-preview-view';

  static const all = <String>{
    homeView,
    shoppingView,
    productView,
    productDescriptionView,
    deleteCategoryView,
    shopPreviewView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.shoppingView,
      page: _i3.ShoppingView,
    ),
    _i1.RouteDef(
      Routes.productView,
      page: _i4.ProductView,
    ),
    _i1.RouteDef(
      Routes.productDescriptionView,
      page: _i5.ProductDescriptionView,
    ),
    _i1.RouteDef(
      Routes.deleteCategoryView,
      page: _i6.DeleteCategoryView,
    ),
    _i1.RouteDef(
      Routes.shopPreviewView,
      page: _i7.ShopPreviewView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.ShoppingView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.ShoppingView(),
        settings: data,
      );
    },
    _i4.ProductView: (data) {
      final args = data.getArgs<ProductViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.ProductView(
            key: args.key, productsService: args.productsService),
        settings: data,
      );
    },
    _i5.ProductDescriptionView: (data) {
      final args = data.getArgs<ProductDescriptionViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProductDescriptionView(
            key: args.key, productsService: args.productsService),
        settings: data,
      );
    },
    _i6.DeleteCategoryView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.DeleteCategoryView(),
        settings: data,
      );
    },
    _i7.ShopPreviewView: (data) {
      final args = data.getArgs<ShopPreviewViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.ShopPreviewView(key: args.key, orderCart: args.orderCart),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProductViewArguments {
  const ProductViewArguments({
    this.key,
    required this.productsService,
  });

  final _i9.Key? key;

  final _i10.ProductsService productsService;

  @override
  String toString() {
    return '{"key": "$key", "productsService": "$productsService"}';
  }

  @override
  bool operator ==(covariant ProductViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.productsService == productsService;
  }

  @override
  int get hashCode {
    return key.hashCode ^ productsService.hashCode;
  }
}

class ProductDescriptionViewArguments {
  const ProductDescriptionViewArguments({
    this.key,
    required this.productsService,
  });

  final _i9.Key? key;

  final _i10.ProductsService productsService;

  @override
  String toString() {
    return '{"key": "$key", "productsService": "$productsService"}';
  }

  @override
  bool operator ==(covariant ProductDescriptionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.productsService == productsService;
  }

  @override
  int get hashCode {
    return key.hashCode ^ productsService.hashCode;
  }
}

class ShopPreviewViewArguments {
  const ShopPreviewViewArguments({
    this.key,
    required this.orderCart,
  });

  final _i9.Key? key;

  final Map<String, String> orderCart;

  @override
  String toString() {
    return '{"key": "$key", "orderCart": "$orderCart"}';
  }

  @override
  bool operator ==(covariant ShopPreviewViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.orderCart == orderCart;
  }

  @override
  int get hashCode {
    return key.hashCode ^ orderCart.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShoppingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.shoppingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductView({
    _i9.Key? key,
    required _i10.ProductsService productsService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productView,
        arguments:
            ProductViewArguments(key: key, productsService: productsService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDescriptionView({
    _i9.Key? key,
    required _i10.ProductsService productsService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDescriptionView,
        arguments: ProductDescriptionViewArguments(
            key: key, productsService: productsService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeleteCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.deleteCategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShopPreviewView({
    _i9.Key? key,
    required Map<String, String> orderCart,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.shopPreviewView,
        arguments: ShopPreviewViewArguments(key: key, orderCart: orderCart),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShoppingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.shoppingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductView({
    _i9.Key? key,
    required _i10.ProductsService productsService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productView,
        arguments:
            ProductViewArguments(key: key, productsService: productsService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductDescriptionView({
    _i9.Key? key,
    required _i10.ProductsService productsService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productDescriptionView,
        arguments: ProductDescriptionViewArguments(
            key: key, productsService: productsService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDeleteCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.deleteCategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShopPreviewView({
    _i9.Key? key,
    required Map<String, String> orderCart,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.shopPreviewView,
        arguments: ShopPreviewViewArguments(key: key, orderCart: orderCart),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

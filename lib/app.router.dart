// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:products_app/core/models/product_model.dart' as _i6;
import 'package:products_app/core/services/products_service.dart' as _i7;
import 'package:products_app/ui/views/category_view.dart' as _i4;
import 'package:products_app/ui/views/home_view.dart' as _i2;
import 'package:products_app/ui/views/product_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i8;

class Routes {
  static const homeView = '/home-view';

  static const productView = '/product-view';

  static const categoryView = '/category-view';

  static const all = <String>{
    homeView,
    productView,
    categoryView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.productView,
      page: _i3.ProductView,
    ),
    _i1.RouteDef(
      Routes.categoryView,
      page: _i4.CategoryView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(nullOk: false);
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(
            key: args.key,
            products: args.products,
            selectedCategory: args.selectedCategory),
        settings: data,
      );
    },
    _i3.ProductView: (data) {
      final args = data.getArgs<ProductViewArguments>(nullOk: false);
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.ProductView(
            key: args.key, productsService: args.productsService),
        settings: data,
      );
    },
    _i4.CategoryView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CategoryView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({
    this.key,
    required this.products,
    required this.selectedCategory,
  });

  final _i5.Key? key;

  final List<_i6.Product> products;

  final String selectedCategory;

  @override
  String toString() {
    return '{"key": "$key", "products": "$products", "selectedCategory": "$selectedCategory"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.products == products &&
        other.selectedCategory == selectedCategory;
  }

  @override
  int get hashCode {
    return key.hashCode ^ products.hashCode ^ selectedCategory.hashCode;
  }
}

class ProductViewArguments {
  const ProductViewArguments({
    this.key,
    required this.productsService,
  });

  final _i5.Key? key;

  final _i7.ProductsService productsService;

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

extension NavigatorStateExtension on _i8.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i5.Key? key,
    required List<_i6.Product> products,
    required String selectedCategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(
            key: key, products: products, selectedCategory: selectedCategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductView({
    _i5.Key? key,
    required _i7.ProductsService productsService,
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

  Future<dynamic> navigateToCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.categoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i5.Key? key,
    required List<_i6.Product> products,
    required String selectedCategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(
            key: key, products: products, selectedCategory: selectedCategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductView({
    _i5.Key? key,
    required _i7.ProductsService productsService,
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

  Future<dynamic> replaceWithCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.categoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

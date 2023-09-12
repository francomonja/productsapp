// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i7;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:products_app/core/services/products_service.dart' as _i8;
import 'package:products_app/ui/views/delete_category_view.dart' as _i5;
import 'package:products_app/ui/views/home_view.dart' as _i2;
import 'package:products_app/ui/views/product_description_view.dart' as _i4;
import 'package:products_app/ui/views/product_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const homeView = '/home-view';

  static const productView = '/product-view';

  static const productDescriptionView = '/product-description-view';

  static const deleteCategoryView = '/delete-category-view';

  static const all = <String>{
    homeView,
    productView,
    productDescriptionView,
    deleteCategoryView,
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
      Routes.productDescriptionView,
      page: _i4.ProductDescriptionView,
    ),
    _i1.RouteDef(
      Routes.deleteCategoryView,
      page: _i5.DeleteCategoryView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.ProductView: (data) {
      final args = data.getArgs<ProductViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.ProductView(
            key: args.key, productsService: args.productsService),
        settings: data,
      );
    },
    _i4.ProductDescriptionView: (data) {
      final args = data.getArgs<ProductDescriptionViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.ProductDescriptionView(
            key: args.key, productsService: args.productsService),
        settings: data,
      );
    },
    _i5.DeleteCategoryView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.DeleteCategoryView(),
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

  final _i7.Key? key;

  final _i8.ProductsService productsService;

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

  final _i7.Key? key;

  final _i8.ProductsService productsService;

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

extension NavigatorStateExtension on _i9.NavigationService {
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

  Future<dynamic> navigateToProductView({
    _i7.Key? key,
    required _i8.ProductsService productsService,
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
    _i7.Key? key,
    required _i8.ProductsService productsService,
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

  Future<dynamic> replaceWithProductView({
    _i7.Key? key,
    required _i8.ProductsService productsService,
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
    _i7.Key? key,
    required _i8.ProductsService productsService,
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
}

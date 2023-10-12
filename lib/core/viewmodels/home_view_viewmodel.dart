import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/app.router.dart';
import 'package:products_app/core/menu_items/menu_items.dart';
import 'package:products_app/core/services/auth_service.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.locator.dart';
import '../constants/storage_keys.dart';
import '../enums/dialog_type.dart';
import '../models/category_model.dart';
import '../models/dolar_model.dart';
import '../models/login_model.dart';
import '../models/product_model.dart';
import '../services/dolar_service.dart';
import '../services/products_service.dart';
import 'package:http/http.dart' as http;

class HomeViewViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final productsService = locator<ProductsService>();
  final categoryService = locator<CategoryService>();
  final AuthService _authService = locator<AuthService>();

  final DialogService _dialogService = locator<DialogService>();
  final FlutterSecureStorage _secureStorage = locator<FlutterSecureStorage>();

  final CategoryService _categoryService = locator<CategoryService>();
  final DolarService _dolarService = locator<DolarService>();
  final TextEditingController categoryController = TextEditingController();
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  List<Product> products = [];
  List<Product> productList = [];
  final storage = FlutterSecureStorage();
  bool isLoading = false;
  bool isSaving = false;
  int navDrawerIndex = 0;
  bool isAuth = false;
  String initialStock = 'Todos';
  Map<String, dynamic> dolar = {'price': ''};
  List<String> stockList = [
    'Todos',
    'Rosario',
    'Oberá',
  ];

  final TextEditingController search = TextEditingController();
  Category selectedCategory = Category(name: 'Todas las categorias');
  List<Category> categoryList = [];

  Future<void> init() async {
    dolar = await _dolarService.loadDolar();
    categoryList = await categoryService.loadCategory();
    products = await productsService.loadProducts();
    productList = products;
    isAuth = await _authService.isAuthenticated();

    notifyListeners();
  }

  findByCategory() async {
    if (selectedCategory.name == 'Todas las categorias') {
      productList = products;
    } else {
      productList = products
          .where((element) => element.category
              .toLowerCase()
              .contains(selectedCategory.name.toLowerCase()))
          .toList();
    }
    if (search.text.isNotEmpty) {
      productList = productList
          .where((element) =>
              element.name.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    }
    if (initialStock != 'Todos') {
      findByStock(initialStock);
    }
    notifyListeners();
  }

  void onTapProduct(id) async {
    final url = Uri.https(_baseUrl, 'products/${id}.json');
    final resp = await http.get(url);
    Map<String, dynamic> jsonMap = json.decode(resp.body);
    productsService.selectedProduct = Product.fromJson(jsonMap, picture: []);
    isAuth ? navigateToProductView() : navigateToProductDescriptionView();
  }

  void navigateToProductView() async {
    await _navigationService.navigateToProductView(
        productsService: productsService);
  }

  void navigateToProductDescriptionView() async {
    await _navigationService.navigateToProductDescriptionView(
        productsService: productsService);
  }

  void navigateToDeleteCategoryView() async {
    await _navigationService.navigateToDeleteCategoryView();
  }

  void navigateToShoppingView() async {
    await _navigationService.navigateToShoppingView();
  }

  void deleteDialog(id, context) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.delete,
      title: '¿Desea eliminar el producto?',
    );
    if (response!.confirmed) {
      onDelete(id);
      notifyListeners();
    }
  }

  void onDelete(id) async {
    await productsService.onDelete(id);
    productList.removeWhere((element) => element.id == id);
    products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void onChangeCategory(value) {
    selectedCategory = value;
    findByStock(initialStock);
    findByCategory();
    notifyListeners();
  }

  void onChangeStock(value) {
    initialStock = value;
    findByStock(initialStock);
    findByCategory();
    notifyListeners();
  }

  void selectedOption(value) async {
    final menuItem = appMenuItems[value];
    navDrawerIndex = value;
    notifyListeners();
    switch (menuItem.link) {
      case 'product-view':
        navigateToProductView();
        productsService.selectedProduct = Product(
          available: false,
          name: '',
          price: 0,
          category: 'ordenar',
          stockRosario: 0,
          stock: 0,
          cost: 0,
          picture: {},
        );
        break;
      case 'category-view':
        dialogCategory();
        break;
      case 'dolar-view':
        dialogDolar();
        break;
      case 'delete-view':
        navigateToDeleteCategoryView();
        break;
      case 'shopping-view':
        navigateToShoppingView();
        break;
    }
  }

  void dialogDolar() async {
    String dolar = _dolarService.listDolar['price'];
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.dolarForm,
      title: 'Ingrese el precio del dolar(Actual: $dolar)',
    );
    if (response!.confirmed) {
      Dolar newDolar = response.data;
      await _dolarService.updateDolar(newDolar);
      init();
    }
  }

  void dialogCategory() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.categoryForm,
      title: 'Ingrese la categoría',
    );
    if (response!.confirmed) {
      Category newCategory = response.data;
      await _categoryService.createCategory(newCategory);
      init();
    }
  }

  void loginDialog(context) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.loginForm,
      title: 'Inicie sesión',
    );
    if (response!.confirmed) {
      Login login = response.data;
      try {
        await _authService.onLogIn(login.user, login.password);
        if (await _authService.isAuthenticated()) {
          init();
          Navigator.pop(context);
          showCustomSnackbar(context, 'Sesión iniciada');
        }
      } catch (e) {
        Navigator.pop(context);
        print(e);
        showCustomSnackbar(context, e.toString());
      }
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    await _secureStorage.delete(key: userToken);
    isAuth = false;
    notifyListeners();
  }

  void showCustomSnackbar(BuildContext context, e) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: Text(e),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  findByStock(value) async {
    initialStock = value;
    if (initialStock == 'Todos') {
      productList = products;
    } else if (initialStock == 'Rosario') {
      productList =
          productList.where((element) => element.stockRosario! > 0).toList();
    } else {
      productList = productList.where((element) => element.stock! > 0).toList();
    }
    notifyListeners();
  }
}

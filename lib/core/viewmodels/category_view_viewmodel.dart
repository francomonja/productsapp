import 'package:flutter/material.dart';
import 'package:products_app/app.locator.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app.router.dart';
import '../models/category_model.dart';

class CategoryViewViewModel extends ChangeNotifier {
  final TextEditingController categoryController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final CategoryService _categoryService = locator<CategoryService>();

  Future<void> createCategory(Category category) async {
    if (categoryController.text.isEmpty) return;
    await _categoryService.createCategory(category);
    navigateToHomeView();
  }

  void navigateToHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}

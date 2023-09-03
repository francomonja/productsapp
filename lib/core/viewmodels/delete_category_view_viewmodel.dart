import 'package:flutter/foundation.dart';
import 'package:products_app/app.locator.dart';
import 'package:products_app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/category_service.dart';

class DeleteCategoryViewViewModel extends ChangeNotifier {
  final CategoryService categoryService = locator<CategoryService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> init() async {
    await categoryService.loadCategory();
    notifyListeners();
  }

  Future<void> deleteCategory(id) async {
    await categoryService.onDelete(id);
    await categoryService.loadCategory();
    notifyListeners();
  }

  void navigateToHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}

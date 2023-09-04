import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/core/services/auth_service.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:products_app/ui/views/delete_category_view.dart';
import 'package:products_app/ui/views/home_view.dart';
import 'package:products_app/ui/views/product_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ProductView),
    MaterialRoute(page: DeleteCategoryView),
  ],
  dependencies: [
    LazySingleton(
      classType: NavigationService,
    ),
    LazySingleton(
      classType: ProductsService,
    ),
    LazySingleton(
      classType: CategoryService,
    ),
    LazySingleton(
      classType: DialogService,
    ),
    LazySingleton(
      classType: AuthService,
    ),
    LazySingleton(
      classType: FlutterSecureStorage,
    ),
    Presolve(
      classType: SharedPreferences,
      presolveUsing: SharedPreferences.getInstance,
    )
  ],
)
class AppSetup {}

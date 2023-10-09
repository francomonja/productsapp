import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/core/services/auth_service.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:products_app/ui/views/delete_category_view.dart';
import 'package:products_app/ui/views/home_view.dart';
import 'package:products_app/ui/views/product_description_view.dart';
import 'package:products_app/ui/views/product_view.dart';
import 'package:products_app/ui/views/shop_preview_view.dart';
import 'package:products_app/ui/views/shopping_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/services/cart_service.dart';
import 'core/services/dolar_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ShoppingView),
    MaterialRoute(page: ProductView),
    MaterialRoute(page: ProductDescriptionView),
    MaterialRoute(page: DeleteCategoryView),
    MaterialRoute(page: ShopPreviewView),
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
      classType: DolarService,
    ),
    LazySingleton(
      classType: AuthService,
    ),
    LazySingleton(
      classType: CartService,
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

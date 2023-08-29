import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    product.available = !product.available;
    print(product.available);
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.id);

    return formKey.currentState?.validate() ?? false;
  }
}

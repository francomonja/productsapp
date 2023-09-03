import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoryFormDialogViewModel extends BaseViewModel {
  final TextEditingController categoryController =
      TextEditingController(text: '');

  List<String> errors = [];
  bool validate() {
    errors.clear();
    if (categoryController.text.isEmpty) errors.add('el campo es requerido');
    notifyListeners();
    return errors.isEmpty;
  }
}

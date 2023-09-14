import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DolarFormDialogViewModel extends BaseViewModel {
  final TextEditingController dolarController = TextEditingController(text: '');

  List<String> errors = [];
  bool validate() {
    errors.clear();
    if (dolarController.text.isEmpty) errors.add('el campo es requerido');
    notifyListeners();
    return errors.isEmpty;
  }
}

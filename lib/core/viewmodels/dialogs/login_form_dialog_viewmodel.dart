import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginFormDialogViewModel extends BaseViewModel {
  final TextEditingController userController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  List<String> errors = [];
  bool validate() {
    errors.clear();
    if (userController.text.isEmpty) errors.add('el campo es requerido');
    if (passwordController.text.isEmpty) errors.add('el campo es requerido');
    notifyListeners();
    return errors.isEmpty;
  }
}

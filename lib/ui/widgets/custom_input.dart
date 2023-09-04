import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}

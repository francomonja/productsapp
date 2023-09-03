import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}

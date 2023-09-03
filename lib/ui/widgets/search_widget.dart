import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.70,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onChanged: (value) => onChanged(),
      ),
    );
  }
}

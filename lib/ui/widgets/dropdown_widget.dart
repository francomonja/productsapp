import 'package:flutter/material.dart';
import 'package:products_app/core/models/category_model.dart';

class DropDownWidget extends StatefulWidget {
  Category selectedValue;
  final List<Category> categoriesList;
  DropDownWidget({
    Key? key,
    required this.onChanged,
    required this.categoriesList,
    required this.selectedValue,
  }) : super(key: key);

  final Function onChanged;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: widget.categoriesList.firstWhere((element) => element.name == widget.selectedValue.name),
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          widget.selectedValue = value!;
        });
      },
      items: widget.categoriesList.map<DropdownMenuItem<Category>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}

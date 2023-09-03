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
      borderRadius: BorderRadius.circular(10),
      value: widget.categoriesList
          .firstWhere((element) => element.name == widget.selectedValue.name),
      icon: const Icon(Icons.arrow_downward),
      underline: Container(
        height: 2,
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
          child: Text(
            value.name,
            style: TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}

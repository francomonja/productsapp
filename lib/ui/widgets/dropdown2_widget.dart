import 'package:flutter/material.dart';

class DropDown2Widget extends StatefulWidget {
  String initialStock;
  final List<String> stockList;
  DropDown2Widget({
    Key? key,
    required this.onChanged,
    required this.stockList,
    required this.initialStock,
  }) : super(key: key);

  final Function onChanged;

  @override
  State<DropDown2Widget> createState() => _DropDown2WidgetState();
}

class _DropDown2WidgetState extends State<DropDown2Widget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      value: widget.stockList
          .firstWhere((element) => element == widget.initialStock),
      icon: const Icon(Icons.arrow_downward),
      underline: Container(
        height: 2,
      ),
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          widget.initialStock = value!;
        });
      },
      items: widget.stockList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}

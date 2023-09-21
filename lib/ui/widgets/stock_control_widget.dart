import 'package:flutter/material.dart';

import '../../core/viewmodels/product_view_viewmodel.dart';

class StockControlWidget extends StatelessWidget {
  final TextEditingController stockController;
  final String name;
  final ProductViewViewModel vm;

  const StockControlWidget({
    super.key,
    required this.vm,
    required this.stockController,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: [
          Text(
            name,
            style: const TextStyle(fontSize: 13),
          ),
          IconButton(
            onPressed: () => vm.clearStock(name),
            icon: const Icon(
              Icons.cancel_outlined,
              size: 20,
            ),
          ),
        ]),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_downward,
                size: 20,
              ),
              onPressed: () => vm.decrementStock(name),
            ),
            Container(
              width: size.width * 0.15,
              child: TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_upward,
                size: 20,
              ),
              onPressed: () => vm.incrementStock(name),
            ),
          ],
        )
      ],
    );
  }
}

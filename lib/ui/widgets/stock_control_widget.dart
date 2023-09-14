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
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(width: 5),
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
              icon: Icon(Icons.arrow_downward),
              onPressed: () => vm.decrementStock(name),
            ),
            Container(
              width: size.width * 0.2,
              child: TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () => vm.incrementStock(name),
            ),
          ],
        )
      ],
    );
  }
}

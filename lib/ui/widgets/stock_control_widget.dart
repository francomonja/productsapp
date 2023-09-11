import 'package:flutter/material.dart';

import '../../core/viewmodels/product_view_viewmodel.dart';

class StockControlWidget extends StatelessWidget {
  final ProductViewViewModel vm;
  StockControlWidget({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: [
          const Text(
            'Stock',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 10),
          TextButton(
              onPressed: () => vm.clearStock(),
              child: const Text(
                'Borrar',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 15,
                ),
              ))
        ]),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () => vm.decrementStock(),
            ),
            Container(
              width: size.width * 0.2,
              child: TextField(
                controller: vm.stockController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                readOnly: true,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () => vm.incrementStock(),
            ),
          ],
        )
      ],
    );
  }
}

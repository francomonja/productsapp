import 'package:flutter/material.dart';

class ShopPreviewView extends StatelessWidget {
  final Map<String, String> orderCart;
  const ShopPreviewView({super.key, required this.orderCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Previsualización del pedido'),
        ),
        body: ListView.builder(
            itemCount: orderCart.length,
            itemBuilder: (context, index) {
              final List<MapEntry<String, String>> entries =
                  orderCart.entries.toList();
              final MapEntry<String, String> entry = entries[index];
              final String valor = entry.value;
              final String clave = entry.key;
              return _CardType1(label: clave, elevation: 5, cart: valor);
            }));
  }
}

class _CardType1 extends StatelessWidget {
  final String cart;
  final String label;
  final double elevation;

  const _CardType1({
    required this.label,
    required this.elevation,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                label,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(
                width: size.width * 0.05,
                child: Text(
                  cart.toString(),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}

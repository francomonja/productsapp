// import 'package:flutter/material.dart';
// import 'package:products_app/core/viewmodels/shopping_view_viewmodel.dart';

// import '../../core/models/product_model.dart';

// class ShoppingCardWidget extends StatelessWidget {
//   final ShoppingViewViewmodel vm;
//   final Product product;
//   const ShoppingCardWidget(
//       {super.key, required this.product, required this.vm});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         margin: const EdgeInsets.only(top: 10, bottom: 10),
//         width: double.infinity,
//         height: 100,
//         decoration: _cardBorders(),
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             _ProductDetails(
//               product: product,
//             ),

//             //TODO mostrar de manera condicional
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: _NotAvailable(
//                   name: 'Stock',
//                   productStock: product.stock,
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// BoxDecoration _cardBorders() => BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black87,
//             blurRadius: 30,
//             offset: Offset(0, 8),
//           )
//         ]);

// class _NotAvailable extends StatelessWidget {
//   final String name;
//   final productStock;
//   const _NotAvailable({super.key, this.productStock, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 40,
//       decoration: BoxDecoration(
//           color: Colors.yellow[800],
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
//       child: FittedBox(
//         fit: BoxFit.contain,
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: (productStock == 0)
//                 ? const Text(
//                     'No disponible',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   )
//                 : Text(
//                     '$name: ${productStock.toString()}',
//                     style: const TextStyle(color: Colors.white, fontSize: 8),
//                   )),
//       ),
//     );
//   }
// }

// class _ProductDetails extends StatelessWidget {
//   final Product product;
//   const _ProductDetails({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 50),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         width: double.infinity,
//         height: 70,
//         decoration: _buildBoxDecoration(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.name,
//               style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               product.category,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BoxDecoration _buildBoxDecoration() => const BoxDecoration(
//       color: Colors.indigo,
//       borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
// }
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product_model.dart';
import '../../core/viewmodels/shopping_view_viewmodel.dart';

class ShoppingCardWidget extends StatelessWidget {
  final ShoppingViewViewmodel vm;
  final Product product;
  const ShoppingCardWidget(
      {super.key, required this.product, required this.vm});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShoppingViewViewmodel>.reactive(
        viewModelBuilder: () => ShoppingViewViewmodel(),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(children: [
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              child: const SafeArea(
                child: Row(
                  children: [
                    Text(
                      'Eliminar categorías',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            ...vm.shopList.map((e) {
              if (e.id != null) {
                return _CardType1(
                  id: e.id!,
                  label: e.name,
                  elevation: 5,
                  vm: vm,
                );
              } else {
                return const SizedBox();
              }
            })
          ])));
        });
  }
}

class _CardType1 extends StatelessWidget {
  final String id;
  final String label;
  final double elevation;
  final ShoppingViewViewmodel vm;

  const _CardType1({
    required this.label,
    required this.elevation,
    required this.vm,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever_outlined)),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}

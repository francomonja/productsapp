import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/shopping_view_viewmodel.dart';
import 'package:products_app/ui/widgets/side_menu_shop_widget.dart';
import 'package:stacked/stacked.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return ViewModelBuilder<ShoppingViewViewmodel>.reactive(
        viewModelBuilder: () => ShoppingViewViewmodel(),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pedido'),
            ),
            endDrawer: SideMenuShop(
              vm: vm,
              scaffoldKey: scaffoldKey,
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              ...vm.shopList.map((e) {
                if (e.id != null) {
                  return _CardType1(
                    cart: vm.shopCart[e.name]!,
                    id: e.id!,
                    label: e.name,
                    elevation: 5,
                    vm: vm,
                  );
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(
                height: 200,
              )
            ])),
            floatingActionButton: FloatingActionButton(
                onPressed: () => vm.saveCart(context),
                child: const Icon(Icons.save_alt_rounded)),
          );
        });
  }
}

class _CardType1 extends StatelessWidget {
  final String cart;
  final String id;
  final String label;
  final double elevation;
  final ShoppingViewViewmodel vm;

  const _CardType1({
    required this.label,
    required this.elevation,
    required this.vm,
    required this.id,
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
              width: size.width * 0.60,
              child: Text(
                label,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            IconButton(
                onPressed: () {
                  vm.decrementCart(label);
                },
                icon: const Icon(Icons.arrow_downward_rounded)),
            SizedBox(
                width: size.width * 0.05,
                child: Text(
                  cart.toString(),
                  textAlign: TextAlign.center,
                )),
            IconButton(
                onPressed: () {
                  vm.increaseCart(label);
                },
                icon: const Icon(Icons.arrow_upward_rounded)),
          ],
        ),
      ),
    );
  }
}

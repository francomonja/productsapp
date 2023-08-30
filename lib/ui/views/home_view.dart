import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product_model.dart';
import '../widgets/product_card.dart';

class HomeView extends StatelessWidget {
  final List<Product> products;
  const HomeView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewViewModel>.reactive(
      viewModelBuilder: () => HomeViewViewModel(),
      builder: (context, vm, child) {
        // vm.loadProducts();
        return Scaffold(
          appBar: AppBar(
            title: Text('Products'),
            actions: [
              IconButton(onPressed: vm.onRefresh, icon: Icon(Icons.refresh)),
            ],
          ),
          body: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    vm.productsService.selectedProduct =
                        vm.productsService.products[index].copy();
                    vm.navigateToProductView();
                  },
                  child: Stack(children: [
                    ProductCard(
                      product: products[index],
                    ),
                    Positioned(
                        bottom: 15,
                        right: 20,
                        child: IconButton(
                            onPressed: () {
                              vm.onDelete(index);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            )))
                  ]))),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                vm.productsService.selectedProduct = Product(
                  available: false,
                  name: '',
                  price: 0,
                  category: 'varios',
                );
                vm.navigateToProductView();
              }),
        );
      },
    );
  }
}

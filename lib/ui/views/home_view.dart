import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product_model.dart';
import '../widgets/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
              itemCount: vm.productsService.products.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    vm.productsService.selectedProduct =
                        vm.productsService.products[index].copy();
                    vm.navigateToProductView();
                  },
                  child: ProductCard(
                    product: vm.productsService.products[index],
                  ))),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                vm.productsService.selectedProduct = Product(
                  available: false,
                  name: '',
                  price: 0,
                );
                vm.navigateToProductView();
              }),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product_model.dart';
import '../widgets/product_card.dart';

class HomeView extends StatelessWidget {
  final List<Product> products;
  final String selectedCategory;
  const HomeView(
      {super.key, required this.products, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewViewModel>.reactive(
      viewModelBuilder: () => HomeViewViewModel(),
      onViewModelReady: (vm) async {
        await vm.init(selectedCategory);
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(selectedCategory),
            actions: [
              vm.isLoading
                  ? CircularProgressIndicator()
                  : IconButton(
                      onPressed: () => vm.onRefresh(selectedCategory),
                      icon: Icon(Icons.refresh))
            ],
          ),
          body: (vm.productList.isEmpty)
              ? const Center(child: Text('Lista vacia'))
              : ListView.builder(
                  itemCount: vm.productList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                          onTap: () {
                            final id = vm.productList[index].id;
                            vm.onTapProduct(id);
                          },
                          child: Stack(children: [
                            ProductCard(
                              product: vm.productList[index],
                            ),
                            Positioned(
                                bottom: 15,
                                right: 20,
                                child: IconButton(
                                    onPressed: () {
                                      vm.onDelete(index, selectedCategory);
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

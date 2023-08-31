import 'package:flutter/material.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:products_app/ui/widgets/search_widget.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product_model.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewViewModel>.reactive(
      viewModelBuilder: () => HomeViewViewModel(),
      onViewModelReady: (vm) async {
        await vm.init();
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [],
          ),
          endDrawer: SafeArea(
            child: Drawer(
              backgroundColor: Colors.blue,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SearchWidget(
                    controller: vm.search,
                    onChanged: vm.findByCategory,
                  ),
                  DropDownWidget(
                    selectedValue: vm.selectedCategory,
                    onChanged: vm.onChangeCategory,
                    categoriesList: vm.categoryList,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    title: Text("Añadir Producto"),
                    onTap: () {
                      vm.productsService.selectedProduct = Product(
                        available: false,
                        name: '',
                        price: 0,
                        category: 'varios',
                      );
                      vm.navigateToProductView();
                    },
                  ),
                  ListTile(
                    title: Text("Añadir Categoria"),
                    onTap: () {
                      vm.categoryService.selectedCategory = Category(
                        name: '',
                      );
                      vm.navigateToCategoryView();
                    },
                  ),
                  ListTile(
                    title: Text("Eliminar Categoria"),
                    onTap: () {
                      //TODO: añadir eliminar con dialogo en pantalla
                    },
                  ),
                ],
              ),
            ),
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
                                      vm.onDelete(vm.productList[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    )))
                          ]))),
        );
      },
    );
  }
}

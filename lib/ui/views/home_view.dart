import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:products_app/ui/widgets/side_menu.dart';
import 'package:stacked/stacked.dart';

import '../widgets/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return ViewModelBuilder<HomeViewViewModel>.reactive(
      viewModelBuilder: () => HomeViewViewModel(),
      onViewModelReady: (vm) async {
        await vm.init();
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(vm.selectedCategory.name),
          ),
          endDrawer: SideMenu(scaffoldKey: scaffoldKey, vm: vm),
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
                            vm.isAuth
                                ? Positioned(
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
                                : const SizedBox()
                          ]))),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/home_view_viewmodel.dart';
import 'package:products_app/ui/widgets/search_widget.dart';

import '../../core/menu_items/menu_items.dart';
import 'dropdown_widget.dart';

class SideMenu extends StatelessWidget {
  final HomeViewViewModel vm;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey, required this.vm});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: vm.navDrawerIndex,
      onDestinationSelected: (value) {
        vm.selectedOption(value);
        scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Buscador'),
                  vm.isAuth
                      ? TextButton(
                          onPressed: () => vm.logOut(),
                          child: const Text('cerrar sesión'))
                      : TextButton(
                          onPressed: () {
                            vm.loginDialog(context);
                          },
                          child: const Text('iniciar sesión'))
                ],
              ),
              const SizedBox(
                height: 10,
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
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        vm.isAuth
            ? const Padding(
                padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
                child: Text('Mas opciones'),
              )
            : const SizedBox(
                height: 1,
              ),
        ...appMenuItems.map((item) => vm.isAuth
            ? NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              )
            : const SizedBox())
      ],
    );
  }
}

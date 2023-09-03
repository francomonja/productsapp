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
              const Text('Buscador'),
              Column(
                children: [
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
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Mas opciones'),
        ),
        ...appMenuItems.map(
          (item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title),
          ),
        ),
      ],
    );
  }
}

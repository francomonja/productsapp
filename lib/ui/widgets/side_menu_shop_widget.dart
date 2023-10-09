import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/shopping_view_viewmodel.dart';

import '../../core/menu_items/menu_items_Shop.dart';

class SideMenuShop extends StatelessWidget {
  final ShoppingViewViewmodel vm;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenuShop({super.key, required this.scaffoldKey, required this.vm});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: vm.navDrawerIndex,
      onDestinationSelected: (value) {
        vm.selectedOption(value, context);
        scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        const SizedBox(
          height: 50,
        ),
        ...appMenuItemsShop.map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )),
      ],
    );
  }
}

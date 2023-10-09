import 'package:flutter/material.dart';

class MenuItemShop {
  final String title;
  final String link;
  final IconData icon;

  const MenuItemShop(
      {required this.title, required this.link, required this.icon});
}

const appMenuItemsShop = <MenuItemShop>[
  MenuItemShop(
    title: 'Pedido Recibido',
    link: 'shop-recived',
    icon: Icons.check_rounded,
  ),
  MenuItemShop(
    title: 'Previsualizar Pedido',
    link: 'shop-preview',
    icon: Icons.remove_red_eye_rounded,
  ),
  MenuItemShop(
    title: 'Vaciar Pedido',
    link: 'shop-clear',
    icon: Icons.delete_forever_rounded,
  ),
];

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

  const MenuItem({required this.title, required this.link, required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Añadir Producto',
    link: 'product-view',
    icon: Icons.save_alt_outlined,
  ),
  MenuItem(
    title: 'Añadir Categoría',
    link: 'category-view',
    icon: Icons.category_outlined,
  ),
  MenuItem(
    title: 'Eliminar Categoría',
    link: 'delete-view',
    icon: Icons.delete_forever_outlined,
  ),
  MenuItem(
    title: 'Cambiar Precio Dolar',
    link: 'dolar-view',
    icon: Icons.price_change_outlined,
  ),
];

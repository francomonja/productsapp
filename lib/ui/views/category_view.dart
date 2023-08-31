import 'package:flutter/material.dart';
import 'package:products_app/core/services/category_service.dart';
import 'package:products_app/core/viewmodels/category_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CategoryView extends StatelessWidget {
  final CategoryService categoryService;
  const CategoryView({super.key, required this.categoryService});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewViewModel>.reactive(
      viewModelBuilder: () => CategoryViewViewModel(),
      builder: (context, vm, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Añadir Categoría'),
                TextFormField(
                  onChanged: (value) =>
                      categoryService.selectedCategory!.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'el nombre es obligatorio';
                    }
                    return null;
                  },
                  autofocus: true,
                  controller: vm.categoryController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      onPressed: vm.navigateToHomeView,
                      child: Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () =>
                          vm.createCategory(categoryService.selectedCategory!),
                      child: Text('Guardar'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/delete_category_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DeleteCategoryView extends StatelessWidget {
  const DeleteCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteCategoryViewViewModel>.reactive(
        viewModelBuilder: () => DeleteCategoryViewViewModel(),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(children: [
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => vm.navigateToHomeView(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'Eliminar categorías',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            ...vm.categoryService.listCategories.map((e) {
              if (e.id != null) {
                return _CardType1(
                  id: e.id!,
                  label: e.name,
                  elevation: 5,
                  vm: vm,
                );
              } else {
                return const SizedBox();
              }
            })
          ])));
        });
  }
}

class _CardType1 extends StatelessWidget {
  final String id;
  final String label;
  final double elevation;
  final DeleteCategoryViewViewModel vm;

  const _CardType1({
    required this.label,
    required this.elevation,
    required this.vm,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    vm.deleteCategory(id);
                  },
                  icon: const Icon(Icons.delete_forever_outlined)),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}

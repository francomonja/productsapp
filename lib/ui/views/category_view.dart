import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/category_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewViewModel>.reactive(
      viewModelBuilder: () => CategoryViewViewModel(),
      builder: (context, vm, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => vm.onPressCamping(),
                  child: Container(
                    height: 75,
                    child: const Card(
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Camping',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => vm.onPressVasos(),
                  child: Container(
                    height: 75,
                    child: const Card(
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Vasos',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => vm.onPressCocina(),
                  child: Container(
                    height: 75,
                    child: const Card(
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Cocina',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => vm.onPressVarios(),
                  child: Container(
                    height: 75,
                    child: const Card(
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Varios',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

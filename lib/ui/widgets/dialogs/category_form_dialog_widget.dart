import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/viewmodels/dialogs/category_form_dialog_viewmodel.dart';
import '../custom_input.dart';
import 'basic_dialog_widget.dart';

class CategoryFormDialogWidget extends StatelessWidget {
  const CategoryFormDialogWidget({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryFormDialogViewModel>.reactive(
        viewModelBuilder: () => CategoryFormDialogViewModel(),
        builder: (context, vm, child) {
          return BasicDialog(
            request: DialogRequest(
                title: request.title,
                data: SafeArea(
                    child: Stack(children: [
                  Column(
                    children: [
                      CustomInput(
                        controller: vm.categoryController,
                        label: 'categoria',
                      ),
                      ...vm.errors.map(
                        (e) => Text(
                          '-$e',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                completer(DialogResponse(confirmed: false));
                              },
                              child: Container(
                                child: Text('cancelar'),
                              )),
                          GestureDetector(
                            onTap: () {
                              if (vm.validate()) {
                                completer(DialogResponse(
                                    confirmed: true,
                                    data: Category(
                                      name: vm.categoryController.text,
                                    )));
                              }
                            },
                            child: Container(
                              child: Text('crear'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]))),
            completer: completer,
          );
        });
  }
}

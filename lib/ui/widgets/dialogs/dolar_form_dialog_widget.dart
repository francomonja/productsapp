import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/models/dolar_model.dart';
import '../../../core/viewmodels/dialogs/category_form_dialog_viewmodel.dart';
import '../../../core/viewmodels/dialogs/dolar_form_dialog_viewmodel.dart';
import '../custom_input.dart';
import 'basic_dialog_widget.dart';

class DolarFormDialogWidget extends StatelessWidget {
  const DolarFormDialogWidget({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DolarFormDialogViewModel>.reactive(
        viewModelBuilder: () => DolarFormDialogViewModel(),
        builder: (context, vm, child) {
          return BasicDialog(
            request: DialogRequest(
                title: request.title,
                data: SafeArea(
                    child: Stack(children: [
                  Column(
                    children: [
                      CustomInput(
                        controller: vm.dolarController,
                        label: '\$',
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
                                    data: Dolar(
                                      price: vm.dolarController.text,
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

import 'package:flutter/material.dart';
import 'package:products_app/core/models/category_model.dart';
import 'package:products_app/core/viewmodels/dialogs/confirmation_dialog_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'basic_dialog_widget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  const ConfirmationDialogWidget({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmationDialogViewmodel>.reactive(
        viewModelBuilder: () => ConfirmationDialogViewmodel(),
        builder: (context, vm, child) {
          return BasicDialog(
            request: DialogRequest(
                title: request.title,
                data: SafeArea(
                    child: Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                completer(DialogResponse(confirmed: false));
                              },
                              child: Container(
                                child: const Text('Cancelar'),
                              )),
                          GestureDetector(
                            onTap: () {
                              completer(DialogResponse(
                                confirmed: true,
                              ));
                            },
                            child: Container(
                              child: const Text('Confirmar'),
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

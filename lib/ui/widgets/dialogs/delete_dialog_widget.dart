import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/dialogs/confirmation_dialog_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/viewmodels/dialogs/delete_dialog_viewmodel.dart';
import 'basic_dialog_widget.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteDialogViewmodel>.reactive(
        viewModelBuilder: () => DeleteDialogViewmodel(),
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

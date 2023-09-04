import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:products_app/core/models/login_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/viewmodels/dialogs/login_form_dialog_viewmodel.dart';
import '../custom_input.dart';
import 'basic_dialog_widget.dart';

class LoginFormDialogWidget extends StatelessWidget {
  const LoginFormDialogWidget({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginFormDialogViewModel>.reactive(
        viewModelBuilder: () => LoginFormDialogViewModel(),
        builder: (context, vm, child) {
          return BasicDialog(
            request: DialogRequest(
                title: request.title,
                data: SafeArea(
                    child: Stack(children: [
                  Column(
                    children: [
                      CustomInput(
                        controller: vm.userController,
                        keyboardType: TextInputType.emailAddress,
                        label: 'usuario',
                      ),
                      CustomInput(
                        controller: vm.passwordController,
                        isPassword: true,
                        label: 'contraseña',
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
                              child: const Text('Cancelar')),
                          GestureDetector(
                            onTap: () {
                              if (vm.validate()) {
                                completer(DialogResponse(
                                    confirmed: true,
                                    data: Login(
                                      user: vm.userController.text,
                                      password: vm.passwordController.text,
                                    )));
                              }
                            },
                            child: const Text('Aceptar'),
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

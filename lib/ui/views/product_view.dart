import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products_app/app.locator.dart';
import 'package:products_app/core/providers/product_form_provider.dart';
import 'package:products_app/core/services/products_service.dart';
import 'package:products_app/core/viewmodels/product_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../decorations/input_decoration.dart';
import '../widgets/product_image.dart';

class ProductView extends StatelessWidget {
  final ProductsService productsService;
  const ProductView({super.key, required this.productsService});

  @override
  Widget build(BuildContext context) {
    final productForm = ProductFormProvider(productsService.selectedProduct!);
    return ViewModelBuilder<ProductViewViewModel>.reactive(
      viewModelBuilder: () => ProductViewViewModel(),
      builder: (context, vm, child) {
        return Scaffold(
          body: SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Stack(
                  children: [
                    ProductImage(url: productsService.selectedProduct?.picture),
                    Positioned(
                        top: 60,
                        left: 20,
                        child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 40,
                              color: Colors.white,
                            ))),
                    Positioned(
                        top: 60,
                        right: 20,
                        child: IconButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final XFile? pickedFile = await picker.pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 100);

                              if (pickedFile == null) {
                                return;
                              }
                              vm.updateSelectedProductImage(pickedFile.path);
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            ))),
                  ],
                ),
                const _ProductForm(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
              onPressed: productsService.isSaving
                  ? null
                  : () async {
                      if (productForm.isValidForm()) return;
                      final String? imageUrl =
                          await productsService.uploadImage();

                      if (imageUrl != null) {
                        productForm.product.picture = imageUrl;
                      }

                      await productsService
                          .saveOrCreateProduct(productForm.product);
                      Navigator.of(context).pop();
                    },
              child: vm.productsService.isSaving
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(Icons.save_alt_outlined)),
        );
      },
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsService = locator<ProductsService>();
    final productForm = ProductFormProvider(productsService.selectedProduct!);
    final product = productForm.product;
    return ViewModelBuilder<ProductViewViewModel>.reactive(
        viewModelBuilder: () => ProductViewViewModel(),
        builder: (context, vm, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: _buildBoxDecoration(),
              child: Form(
                  key: productForm.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: const Text('categoría'),
                        children: [
                          RadioListTile(
                            title: const Text('camping'),
                            value: vm.camping,
                            groupValue: vm.selectedCategory,
                            onChanged: (value) {
                              vm.change(vm.camping);
                            },
                          ),
                          RadioListTile(
                            title: const Text('cocina'),
                            value: vm.cocina,
                            groupValue: vm.selectedCategory,
                            onChanged: (value) {
                              vm.change(vm.cocina);
                            },
                          ),
                          RadioListTile(
                            title: const Text('varios'),
                            value: vm.varios,
                            groupValue: vm.selectedCategory,
                            onChanged: (value) {
                              vm.change(vm.varios);
                            },
                          ),
                          RadioListTile(
                            title: const Text('vasos'),
                            value: vm.vasos,
                            groupValue: vm.selectedCategory,
                            onChanged: (value) {
                              vm.change(vm.vasos);
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        onChanged: (value) => product.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'el nombre es obligatorio';
                          }
                          return null;
                        },
                        initialValue: product.name,
                        decoration: InputDecorations.authInputDecoration(
                          hintText: 'Nombre del producto',
                          labelText: 'Nombre:',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (double.tryParse(value) == null) {
                            product.price = 0;
                          } else {
                            product.price = double.parse(value);
                          }
                        },
                        initialValue: '${product.price}',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecorations.authInputDecoration(
                          hintText: '\$150',
                          labelText: 'precio:',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SwitchListTile.adaptive(
                        title: const Text('Disponible'),
                        value: product.available,
                        onChanged: vm.updateAvailability,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:products_app/core/models/product_model.dart';
import 'package:products_app/core/viewmodels/product_description_view_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/services/products_service.dart';
import '../widgets/product_image.dart';

class ProductDescriptionView extends StatelessWidget {
  final ProductsService productsService;
  const ProductDescriptionView({super.key, required this.productsService});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDescriptionViewViewmodel>.reactive(
      viewModelBuilder: () => ProductDescriptionViewViewmodel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SizedBox(
                  height: 450,
                  child: Swiper(
                    pagination: const SwiperPagination(),
                    itemCount: productsService.selectedProduct!.picture!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ProductImage(
                              url: productsService
                                  .selectedProduct!.picture!['picture$index']),
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
                        ],
                      );
                    },
                  ),
                ),
                _ProductForm(product: productsService.selectedProduct!),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductForm extends StatelessWidget {
  final Product product;
  const _ProductForm({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '${product.name}',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${product.price.toString()}',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Stock Oberá: ${product.stock}',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Stock Rosario: ${product.stockRosario}',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Categoría: ${product.category}',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                product.description ?? '',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.grey[350],
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

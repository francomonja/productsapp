import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:products_app/core/viewmodels/product_view_viewmodel.dart';

import '../../core/models/product_model.dart';

class PictureSwiperWidget extends StatelessWidget {
  final Product product;
  final ProductViewViewModel vm;

  const PictureSwiperWidget(
      {super.key, required this.product, required this.vm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 3,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          return Hero(
            tag: index + 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: vm.showImage(index, product),
            ),
          );
        },
      ),
    );
  }
}

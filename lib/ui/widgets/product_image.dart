import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  final PhotoViewController _controller = PhotoViewController();
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    }
    if (picture.startsWith('http')) {
      return PhotoView(
        imageProvider: NetworkImage(picture),
        minScale: PhotoViewComputedScale.contained,
        initialScale: PhotoViewComputedScale.contained,
        onTapUp: (context, details, controllerValue) {
          if (_controller.scale != 1.0) {
            _controller.reset(); // Vuelve a la página inicial (tamaño original)
          }
        },
        onTapDown: (context, details, controllerValue) {
          if (_controller.scale != 1.0) {
            _controller.reset(); // Vuelve a la página inicial (tamaño original)
          }
        },
      );
    }

// FadeInImage(
//           image: NetworkImage(url!),
//           placeholder: const AssetImage('assets/jar-loading.gif'),
//           fit: BoxFit.cover,
//         ),
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../models/product_model.dart';

class ProductsService {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  final storage = FlutterSecureStorage();
  Product? selectedProduct;
  bool isLoading = true;
  bool isSaving = false;
  List<File?> newPictureFile = [];
  var uuid = Uuid();
  List<String> pictureList = [];

  Future<List<Product>> loadProducts() async {
    List<Product> tempProduct = [];
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
        // Verificar si el campo "picture" existe y es de tipo Map<String, dynamic>
        if (value['picture'] != null &&
            value['picture'] is Map<String, dynamic>) {
          final Map<String, dynamic> pictureMap = value['picture'];

          // Crear una lista de URLs de imágenes para el Producto
          final pictureUrls = pictureMap.values.toList().cast<String>();

          // Crear y añadir el Producto a la lista
          tempProduct.add(Product.fromJson(value, picture: pictureUrls));
        }
      });
    } catch (error) {
      print('Error: $error');
    }
    tempProduct.sort((a, b) => a.name.compareTo(b.name));
    return tempProduct;
  }
  // Future<List<Product>> loadProducts() async {
  //   List<Product> tempProduct = [];
  //   final url = Uri.https(_baseUrl, 'products.json');
  //   final resp = await http.get(url);
  //   try {
  //     final Map<String, dynamic> productsMap = json.decode(resp.body);
  //     productsMap.forEach((key, value) {
  //       tempProduct.add(Product.fromJson(value));
  //     });
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  //   tempProduct.sort((a, b) => a.name.compareTo(b.name));
  //   return tempProduct;
  // }

  Future saveOrCreateProduct(Product product) async {
    if (product.id == null) {
      //Crear
      await createProduct(product);
    } else {
      //Actualizar
      await updateProduct(product);
    }
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.put(url, body: product.toRawJson());
    // ignore: unused_local_variable
    final decodedData = resp.body;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    product.id = uuid.v4();
    final url = Uri.https(_baseUrl, 'products/${product.id}.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    await http.put(url, body: product.toRawJson());
    print(product.toRawJson());
    return product.id!;
  }

// Map<String, dynamic> pictureMap = {}; // Crear un mapa vacío
// for (int i = 0; i < pictureList.length; i++) {
//   pictureMap['picture$i'] = pictureList[i]; // Asignar cada URL como valor del mapa usando la clave 'picture$i'
// }
  // void updateSelectedProductImage(String path, int i) {
  //   selectedProduct!.picture!['picture$i'] = path;
  //   int long = selectedProduct!.picture!.length;
  //   newPictureFile.clear();
  //   for (var i = 0; i < long; i++) {
  //     newPictureFile.add(File(selectedProduct!.picture!['picture$i']));
  //   }
  //   if (newPictureFile.length > i) {
  //     newPictureFile.insert(i, File(path));
  //   } else {
  //     newPictureFile.add(File(path));
  //   }
  //   print(newPictureFile);
  // }
  void updateSelectedProductImage(String path, int i) {
    if (selectedProduct!.picture != null) {
      // Actualiza la imagen en selectedProduct
      selectedProduct!.picture!['picture$i'] = path;

      // Actualiza newPictureFile basado en la longitud de selectedProduct.picture
      newPictureFile.clear();
      for (var j = 0; j < selectedProduct!.picture!.length; j++) {
        if (selectedProduct!.picture!.containsKey('picture$j')) {
          newPictureFile.add(File(selectedProduct!.picture!['picture$j']));
        }
      }

      print(newPictureFile);
    }
  }

  Future<List<String?>?> uploadImage() async {
    if (newPictureFile.isEmpty) {
      return null;
    }
    List<String> decodedDataList = [];

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dgagjc77g/image/upload?upload_preset=puyyq9zb');

    for (var i = 0; i < newPictureFile.length; i++) {
      if (newPictureFile[i]!.path.startsWith('https')) {
        decodedDataList.add(newPictureFile[i]!.path);
      } else {
        final imageUploadRequest = http.MultipartRequest('POST', url);
        final file =
            await http.MultipartFile.fromPath('file', newPictureFile[i]!.path);
        imageUploadRequest.files.add(file);
        final streamResponse = await imageUploadRequest.send();
        final resp = await http.Response.fromStream(streamResponse);
        if (resp.statusCode != 200 && resp.statusCode != 201) {
          print('algo salio mal');
          print(resp.body);
          return null;
        }
        final decodedData = json.decode(resp.body);
        decodedDataList.add(decodedData['secure_url']);
      }
    }

    newPictureFile = [];

    // Modificar el mapa selectedProduct!.picture con las URLs subidas
    final pictureMap = <String, dynamic>{};

    // for (var i = 0; i < decodedDataList.length; i++) {
    //   pictureMap['picture$i'] = decodedDataList[i];
    // }

    int pictureIndex = 0; // Usar un índice incremental
    for (var imageUrl in decodedDataList) {
      pictureMap['picture$pictureIndex'] = imageUrl;
      pictureIndex++;
    }

    print(pictureMap);
    selectedProduct!.picture = pictureMap;

    final databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef
        .child('products')
        .child(selectedProduct!.id!)
        .child('picture') // Acceder a la subclave 'picture'
        .set(pictureMap); // Utilizar set en lugar de update

    return decodedDataList;
  }

  // Future<List<String?>?> uploadImage() async {
  //   if (newPictureFile.isEmpty) return null;
  //   List<String> decodedDataList = [];

  //   final url = Uri.parse(
  //       'https://api.cloudinary.com/v1_1/dgagjc77g/image/upload?upload_preset=puyyq9zb');
  //   final imageUploadRequest = http.MultipartRequest('POST', url);

  //   for (var i = 0; i < newPictureFile.length; i++) {
  //     final file =
  //         await http.MultipartFile.fromPath('file', newPictureFile[i]!.path);
  //     imageUploadRequest.files.add(file);
  //     final streamResponse = await imageUploadRequest.send();
  //     final resp = await http.Response.fromStream(streamResponse);
  //     if (resp.statusCode != 200 && resp.statusCode != 201) {
  //       print('algo salio mal');
  //       print(resp.body);
  //       return null;
  //     }
  //     final decodedData = json.decode(resp.body);
  //     decodedDataList.add(decodedData);
  //   }
  //   newPictureFile = [];
  //   return decodedDataList;
  // }

  onDelete(id) async {
    try {
      final url = Uri.https(_baseUrl, 'products/$id.json');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting product: $error');
    }
  }
}

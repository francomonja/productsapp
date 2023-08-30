import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  final storage = FlutterSecureStorage();
  Product? selectedProduct;
  bool isLoading = true;
  bool isSaving = false;
  File? newPictureFile;

  ProductsService() {
    loadProducts();
    notifyListeners();
  }

  Future<List<Product>> loadProducts() async {
    products.clear();
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
        final tempProduct = Product.fromJson(value);
        tempProduct.id = key;
        products.add(tempProduct);
      });
    } catch (error) {
      print('Error: $error');
    }
    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //Crear
      await createProduct(product);
    } else {
      //Actualizar
      await updateProduct(product);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.put(url, body: product.toRawJson());
    // ignore: unused_local_variable
    final decodedData = resp.body;

    //TODO actualizar listado de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.post(url, body: product.toRawJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];
    products.add(product);
    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct!.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dgagjc77g/image/upload?upload_preset=puyyq9zb');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }
    newPictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  onDelete(index) async {
    await loadProducts();

    try {
      final url = Uri.https(_baseUrl, 'products/${products[index].id}.json');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting product: $error');
    }
    products.removeAt(index);
    notifyListeners();
    return products;
  }
}

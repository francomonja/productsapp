import 'dart:convert';
import 'dart:io';

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
  File? newPictureFile;
  var uuid = Uuid();

  Future<List<Product>> loadProducts() async {
    List<Product> tempProduct = [];
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
        tempProduct.add(Product.fromJson(value));
      });
    } catch (error) {
      print('Error: $error');
    }
    return tempProduct;
  }

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

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct!.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dgagjc77g/image/upload?upload_preset=puyyq9zb');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
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

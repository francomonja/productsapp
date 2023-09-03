import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../models/category_model.dart';

class CategoryService {
  final String _baseUrl = 'productsapp-6ee2d-default-rtdb.firebaseio.com';
  final storage = FlutterSecureStorage();
  Category? selectedCategory;
  var uuid = Uuid();
  List<Category> listCategories = [];

  Future<List<Category>> loadCategory() async {
    List<Category> categoryList = [];
    final url = Uri.https(_baseUrl, 'categories.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    final resp = await http.get(url);
    try {
      final Map<String, dynamic> categoriesMap = jsonDecode(resp.body);
      categoriesMap.forEach((key, value) {
        categoryList.add(Category.fromJson(value));
      });
    } catch (error) {
      print('Error: $error');
    }
    listCategories = categoryList;
    return categoryList;
  }

  Future createCategory(Category category) async {
    category.id = uuid.v4();
    final url = Uri.https(_baseUrl, 'categories/${category.id}.json', {
      'auth': await storage.read(key: 'token') ?? '',
    });
    await http.put(url, body: category.toRawJson());

    return category.id!;
  }

  Future onDelete(id) async {
    try {
      final url = Uri.https(_baseUrl, 'categories/$id.json');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Category deleted successfully');
      } else {
        print('Failed to delete category. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting category: $error');
    }
  }
}

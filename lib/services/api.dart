import 'dart:convert';
import 'package:final_project/models/category.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = "https://dummyjson.com/products";

  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products?limit=200"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List productsJson = data['products'];
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products?limit=200"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List productsJson = data['products'];

      final Map<String, String> categoryMap = {};

      for (var product in productsJson) {
        final category = product['category'];
        final thumbnail = product['thumbnail'];

        categoryMap.putIfAbsent(category, () => thumbnail);
      }

      return categoryMap.entries
          .map((entry) => Category(name: entry.key, thumbnail: entry.value))
          .toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products/category/$category"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List productsJson = data['products'];
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}

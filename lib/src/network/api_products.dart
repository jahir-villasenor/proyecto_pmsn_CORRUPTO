import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_api.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/category_api.dart';

class ApiProducts {
  late Dio _dio;

  ApiProducts() {
    _dio = Dio();
    _dio.options.baseUrl = 'https://fakestoreapi.com';
  }

  Future<List<ProductApi>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.map((item) => ProductApi.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API');
    }
  }

  Future<List<CategoryApi>> getProductCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final categories = data
            .cast<String>()
            .map((c) => CategoryApi(categoryapi: c))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API');
    }
  }
}

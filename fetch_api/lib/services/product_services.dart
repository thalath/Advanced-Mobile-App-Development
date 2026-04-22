import 'package:fetch_api/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<ProductModel>?> readProductApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        return compute(productFromJson, response.body);
      }
      throw Exception("Error Status: ${response.statusCode}");
    } catch (e) {
      Exception("Exception: ${e.toString()}");
    }
    return null;
  }
}


import 'package:e_commerce/models/product_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<ProductModel>> readApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        return compute(productModelFromJson, response.body);
      }

      throw Exception("Error statusCode: ${response.statusCode} ");
    } catch (e) {
      throw Exception("Exception: ${e.toString()}");
    }
  }
}

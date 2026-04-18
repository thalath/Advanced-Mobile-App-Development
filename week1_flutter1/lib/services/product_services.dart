import 'package:flutter/foundation.dart';
import 'package:week1_flutter1/models/product_models.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<ProductModels>> readApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        return compute(productFromJson, response.body);
      }
      throw Exception("Error Status: ${response.statusCode}");
    } catch (e) {
      throw Exception("Exception ${e.toString()}");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreenController with ChangeNotifier {
  Future<void> fetchProductDetail() async {
    final url = Uri.parse("https://fakestoreapi.com/products/1");

    var responseData = await http.get(url);

    // print(responseData.statusCode);
    // print(responseData.body);
  }
}

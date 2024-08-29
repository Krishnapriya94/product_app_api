import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app_api/model/product_detail_screen/product_detail_screen.dart';

class ProductDetailsController with ChangeNotifier {
  ProductByIdModel? productByIdModel;

  getSingleProduct(String productId) async {
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");

    var responseData = await http.get(url);
    print(responseData.body);

    if (responseData.statusCode == 200) {
      productByIdModel = productByIdModelFromJson(responseData.body);
    }
    notifyListeners();
  }
}

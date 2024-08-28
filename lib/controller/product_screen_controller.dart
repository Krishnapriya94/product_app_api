import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app_api/model/product_screen/product_res_model.dart';

class ProductScreenController with ChangeNotifier {
  List<ProductResModel>? productsData;
  int selectedIndex = 0;

  List categoriesList = ["All"];

  // Future<void> getAllProducts() async {
  //   final url = Uri.parse("https://fakestoreapi.com/products");

  //   var responseData = await http.get(url);

  //   print(responseData.statusCode);
  //   print(responseData.body);

  //   if (responseData.statusCode == 200) {
  //     productsData = productResModelFromJson(responseData.body);

  //     print(productsData);
  //   }
  //   notifyListeners();
  // }

  Future<void> getCategories() async {
    final url = Uri.parse("https://fakestoreapi.com/products/categories");
    var res = await http.get(url);

    if (res.statusCode == 200) {
      categoriesList.addAll(jsonDecode(res.body));
      print(categoriesList);
    }
    notifyListeners();
  }

  changeTabColor(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

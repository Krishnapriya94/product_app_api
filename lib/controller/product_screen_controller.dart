import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:product_app_api/model/product_screen/product_res_model.dart';

class ProductScreenController with ChangeNotifier {
  //to assign all the products from all producta API
  List<ProductResModel> productsData = [];
  int selectedIndex = 0;
  int? selectFavorite;

  bool isCategoryLoading = false; //to load categories
  bool isProductLoading = false; //to load products

  List categoriesList = ["All"];

  //to fetch all products
  Future<void> getAllProducts() async {
    isProductLoading = true;
    final url = Uri.parse("https://fakestoreapi.com/products");

    var responseData = await http.get(url);

    print(responseData.statusCode);
    print(responseData.body);

    if (responseData.statusCode == 200) {
      productsData = productResModelFromJson(responseData.body);

      print(productsData);
    }
    isProductLoading = false;
    notifyListeners();
  }

//to fetch category list
  Future<void> getCategories() async {
    isCategoryLoading = true;
    final url = Uri.parse("https://fakestoreapi.com/products/categories");
    var responseData = await http.get(url);

    if (responseData.statusCode == 200) {
      categoriesList.addAll(jsonDecode(responseData.body));
      print(categoriesList);
    }
    isCategoryLoading = false;
    notifyListeners();
  }

//select category from list
  onCategorySelection(int index) {
    selectedIndex = index;

    if (selectedIndex == 0) {
      getAllProducts();
    } else {
      getProductByCategory(category: categoriesList[selectedIndex]);
    }
    notifyListeners();
  }
//https://fakestoreapi.com/products/category/jewelery

  Future<void> getProductByCategory({String category = ""}) async {
    //to fetch the products by category
    isProductLoading = true;
    final url =
        Uri.parse("https://fakestoreapi.com/products/category/$category");

    var responseData = await http.get(url);

    print(responseData.statusCode);
    print(responseData.body);

    if (responseData.statusCode == 200) {
      productsData = productResModelFromJson(responseData.body);
      print(productsData);
    }
    isProductLoading = false;
    notifyListeners();
  }

  void favoriteSelection({required int index}) {
    // selectFavorite = index;
    // notifyListeners();
  }
}

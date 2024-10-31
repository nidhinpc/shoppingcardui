import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingcardui/model/shop_model.dart';

class CategoryController with ChangeNotifier {
  List<ShopModels>? shopModels = [];
  bool isProductLoading = false;
  List categorylist = [];
  bool isLoading = false;
  int selectedCategoryIndex = 0;
  Future getdata() async {
    final url = Uri.parse("https://fakestoreapi.com/products/categories");

    try {
      isLoading = true;
      notifyListeners();
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var convertedData = jsonDecode(response.body);
        // print(convertedData);
        categorylist = convertedData;
        categorylist.insert(0, "All");
        print(categorylist);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  onCategorySelection(int clickedindex) async {
    if (selectedCategoryIndex != clickedindex && isProductLoading == false) {
      selectedCategoryIndex = clickedindex;
      notifyListeners();
      await getStore();
    }
  }

  Future<void> getStore() async {
    final allProductsurl = Uri.parse("https://fakestoreapi.com/products");
    final productByCategoryurl = Uri.parse(
        "https://fakestoreapi.com/products/category/${categorylist[selectedCategoryIndex]}");
    try {
      isProductLoading = true;
      notifyListeners();
      final response = await http.get(
          selectedCategoryIndex == 0 ? allProductsurl : productByCategoryurl);
      if (response.statusCode == 200) {
        var responsedata = shopModelsFromJson(response.body);
        shopModels = responsedata;
        print(shopModels);
      }
    } catch (e) {
      print(e);
    }
    isProductLoading = false;
    notifyListeners();
  }

  getProductsByCategory() {}
}

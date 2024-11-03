import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingcardui/model/shop_model.dart';

class ProductDetailControl with ChangeNotifier {
  ShopModels? product;
  bool isLoading = false;

  getProductdetail(int productId) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/${productId}");
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        product = ShopModels.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}

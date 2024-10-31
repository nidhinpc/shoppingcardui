// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shoppingcardui/model/shop_model.dart';

// class HomeScreenController with ChangeNotifier {
//   List<ShopModels>? shopModels = [];
//   bool isProductLoading = false;

//   Future<void> getStore() async {
//     final url = Uri.parse("https://fakestoreapi.com/products");
//     try {
//       isProductLoading = true;
//       notifyListeners();
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         var responsedata = shopModelsFromJson(response.body);
//         shopModels = responsedata;
//         print(shopModels);
//       }
//     } catch (e) {
//       print(e);
//     }
//     isProductLoading = false;
//     notifyListeners();
//   }
// }

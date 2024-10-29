import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryController with ChangeNotifier {
  List categorylist = [];
  Future getdata() async {
    final url = Uri.parse("https://fakestoreapi.com/products/categories");

    try {
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
  }
}

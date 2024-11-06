import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcardui/model/shop_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class MyCartController with ChangeNotifier {
  double totalCartVAlue = 0.00;
  late Database database;
  List<Map> storedProducts = [];

  Future initDb() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase("cartdb4.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, amount REAL, image TEXT, productId INTIGER)');
    });
    await getAllProducts();
  }

  Future getAllProducts() async {
    storedProducts =
        await database.rawQuery('SELECT * FROM Cart'); //* means  all data
    log(storedProducts.toString());
    calculateTotalAmout();
    notifyListeners();
  }

  Future addProduct(ShopModels selectedProduct) async {
    // bool alreadyIncart = false;
    // for (int i = 0; i < storedProducts.length; i++) {
    //  if() selectedProduct.id == storedProducts[i]["productId"]) {
    //   alreadyAdded = true;
    // }
    // }
    // if(alreadyIncart){
    //   log("already in cart");
    // } else {
    //    await database.rawInsert(
    //       'INSERT INTO Cart(name, qty, discription, image) VALUES(?, ?, ?, ?)',
    //       [
    //         selectedProduct.title,
    //         1,
    //         selectedProduct.description,
    //         selectedProduct.image
    //       ]);
    // }
    bool alreadyIncart = storedProducts.any(
      (element) => selectedProduct.id == element["productId"],
    );
    if (alreadyIncart) {
      print("already in cart");
    } else {
      await database.rawInsert(
          'INSERT INTO Cart(name, qty, amount, image, productId) VALUES(?, ?, ?, ?, ?)',
          [
            selectedProduct.title,
            1,
            selectedProduct.price,
            selectedProduct.image,
            selectedProduct.id
          ]);
    }
    getAllProducts();
  }

  Future<void> incrementQty(int id, int currentQty) async {
    int newQty = currentQty + 1;

    await database.rawUpdate(
      'UPDATE Cart SET qty = ? WHERE id = ?',
      [newQty, id],
      //[++currentQty, id]
    );

    await getAllProducts();
  }

  Future decrementQty(int id, int currentQty) async {
    if (currentQty > 1) {
      int newQty = currentQty - 1;

      await database.rawUpdate(
        'UPDATE Cart SET qty = ? WHERE id = ?',
        [newQty, id],
      );
    }

    getAllProducts();
  }

  Future removeProduct(int productId) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [productId]);
    await getAllProducts();
  }

  void calculateTotalAmout() {
    totalCartVAlue = 0.00;
//  for (int i=0;i< storedProducts.length;i++){
//   totalCartVAlue = totalCartVAlue+(storedProducts[i]["qty"] *  storedProducts[i]["amount"])

//  }
    for (var element in storedProducts) {
      totalCartVAlue = totalCartVAlue + (element["qty"] * element["amount"]);
      log(totalCartVAlue.toString());
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppingcardui/model/shop_model.dart';
import 'package:sqflite/sqflite.dart';

class MyCartController with ChangeNotifier {
  late Database database;
  List<Map> storedProducts = [];

  Future initDb() async {
    database = await openDatabase("cartdb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, discription TEXT, image TEXT)');
    });
  }

  Future getAllProducts() async {
    storedProducts =
        await database.rawQuery('SELECT * FROM Cart'); //* means  all data
    log(storedProducts.toString());
    notifyListeners();
  }

  Future addProduct(ShopModels selectedProduct) async {
    await database.rawInsert(
        'INSERT INTO Cart(name, qty, discription, image) VALUES(?, ?, ?, ?)', [
      selectedProduct.title,
      1,
      selectedProduct.description,
      selectedProduct.image
    ]);
    notifyListeners();
  }

  Future incrementQty(
      String name, String discription, int qty, String image, int id) async {
    await database.rawUpdate(
        'UPDATE Cart SET name = ?, qty = ?, discription = ?, image =? WHERE id = ?',
        [name, qty, discription, image, id]);
    getAllProducts();
  }

  Future decrementQty(
      String name, String discription, int qty, String image, int id) async {
    await database.rawUpdate(
        'UPDATE Cart SET name = ?, qty = ?, discription = ?, image =? WHERE id = ?',
        [name, qty, discription, image, id]);
    getAllProducts();
  }

  Future removeProduct(int id) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [id]);
    getAllProducts();
  }
}



// import 'package:sqflite/sqflite.dart';

// class HomeScreenController {
//   static late Database myDatabase;
//   static List<Map> employeeDataList = [];
//   static Future initDb() async {
//     // open the database
//     myDatabase = await openDatabase("employeeData.db", version: 1,
//         onCreate: (Database db, int version) async {
//       // When creating the db, create the table
//       await db.execute(
//           'CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
//     });
//   }

//   static Future addEmployee({required name, required designation}) async {
//     await myDatabase.rawInsert(
//         'INSERT INTO employee(name, designation) VALUES(?, ?)',
//         [name, designation]);
//     getAllEmployee();
//   }

//   static Future getAllEmployee() async {
//     employeeDataList = await myDatabase.rawQuery('SELECT * FROM employee');
//     print(employeeDataList);
//   }

//   static Future removeEmployee(int id) async {
//     await myDatabase.rawDelete('DELETE FROM employee WHERE id = ?', [id]);
//     getAllEmployee();
//   }

//   static Future updateEmployee(
//       String newName, String newDesignation, int id) async {
//     await myDatabase.rawUpdate(
//         'UPDATE employee SET name = ?, designation = ? WHERE id = ?',
//         [newName, newDesignation, id]);
//     getAllEmployee();
//   }
// }


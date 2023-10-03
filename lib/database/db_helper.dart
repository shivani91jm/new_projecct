import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
class DatabaseHelper{
  static Database? _database;
  Future<Database?> get database async{
    if(_database!=null)
      {
        return _database;
      }
    _database=await inilizationDatabase();

    return null;
  }
  inilizationDatabase() async{
    io.Directory documentDirectory=await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,"cart.db");
    var db=await openDatabase(path,version: 2,onCreate: onCreate,);
    return db;
  }
  onCreate(Database db,int version)async {
    await db.execute("CREATE TABLE product_cart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId VARCHAR UNIQUE, productName TEXT,productDetails TEXT,initilPrice DOUBLE,productPrice DOUBLE,qunatity INTEGER,image TEXT )"
    );

  }
  Future<CartModelClass> insert(CartModelClass cartModelClass)async{
    var dbClient =await database;
    await dbClient!.insert("product_cart", cartModelClass.toMap());
    return cartModelClass;
  }
  Future<List<CartModelClass>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('product_cart');
    return queryResult.map((result) => CartModelClass.fromJson(result)).toList();
  }
  //-----------------update quantity----------------------------
  Future<int> updateQuantity(CartModelClass cart) async {
    var dbClient = await database;
   var id= await dbClient!.update('product_cart',cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
     print("update value"+id.toString());

    return id;
  }
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('product_cart', where: 'productId = ?', whereArgs: [id]);
  }
}

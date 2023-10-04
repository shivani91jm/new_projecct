import 'dart:core';
import 'package:flutter/material.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper();
  int _counter=0;
  int _quantity = 1;
  int get counter => _counter;
  double _totalPrice= 0.0;
  double  get totalPrice => _totalPrice;
  int get quantity=> _quantity;
  late Future<List<CartModelClass>> cart;
  Future<List<CartModelClass>>  get carts => cart;
  int _totalTex=0;
  int get totalTax=>_totalTex;
  Future<List<CartModelClass>> getData() async {
    cart =  dbHelper.getCartList();

    return cart;
  }
  void setPrefernceItem() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_counter', _counter);
    prefs.setDouble('cart_totalprice',_totalPrice);
    prefs.setInt('item_quantity', _quantity);
    notifyListeners();
  }
  void getPreferenceItem() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter=prefs.getInt('cart_counter') ?? 0;
    _quantity=prefs.getInt('item_quantity') ?? 1;
   _totalPrice= prefs.getDouble('cart_totalprice') ?? 0.0;
   notifyListeners();
  }
  void addCounter(){
    _counter++;
    setPrefernceItem();
    notifyListeners();
  }
  void removeCounter(){
    _counter--;
    setPrefernceItem();
    notifyListeners();
  }
  int getCounter(){
    getPreferenceItem();
    return _counter;
  }
  void addTotalPrice(double totalpricevalue){
    _totalPrice=_totalPrice+totalpricevalue;
    setPrefernceItem();
    notifyListeners();

  }
  void removeTotalPrice(double totalpricevalue){
    _totalPrice=_totalPrice-totalpricevalue;
    setPrefernceItem();
    notifyListeners();
  }
  double getTotalPrice(){
    getPreferenceItem();
    return _totalPrice;
  }

  int getQuantity(int quantity) {
    getPreferenceItem();
    return _quantity;
  }


}
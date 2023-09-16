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
  List<CartModelClass> cart = [];
  List<CartModelClass>  get carts => cart;
  Future<List<CartModelClass>> getData() async {
    cart = await dbHelper.getCartList();
    notifyListeners();
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
  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    setPrefernceItem();
    notifyListeners();
  }
  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity!.value = currentQuantity - 1;
    }
    setPrefernceItem();
    notifyListeners();
  }
  int getQuantity(int quantity) {
    getPreferenceItem();
    return _quantity;
  }
  void removeItem(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
   setPrefernceItem();
    notifyListeners();
  }

}
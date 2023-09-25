import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/AllOrder/OrderModelClass.dart';

class AllOrdersController extends GetxController{
  var text="";
  RxBool isLoading=false.obs;
  RxList<OrderModelClass> datass=<OrderModelClass>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }
  void loadData() async{
  var url="https://palrancho.co/wp-json/wc/v3/orders?consumer_key=ck_0def1385963b008287e6d7aa1bff5a63f9a89880&consumer_secret=cs_bc192e77a03225f3bceef8d913c47692b0716869";
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },);
  if (response.statusCode == 200)
  {
    isLoading.value = false;
    List<dynamic> data=json.decode(response.body);
    print("data"+data.toString());
    data.map((e) {
      OrderModelClass datas = OrderModelClass.fromJson(e);
      datass.add(datas);
      print("futureCategoriewsdata" + datass.length.toString());

    }).toList();
  }
  else if(response.statusCode==500 || response.statusCode==403)
  {
    isLoading.value=false;
    List<dynamic> jsonResponse = json.decode(response.body);
    print("json response"+jsonResponse.toString());
    CommonUtilsClass.toastMessage("Server side Error");
  }
  else {
    throw Exception('Failed to load album');
  }
}
}
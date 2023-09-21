import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class AllOrdersController extends GetxController{
  var text="";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }
void loadData() async{
  var url="https://palrancho.co/wp-json/wp/v2/pages/11159";
  final response = await http.get(Uri.parse(url), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },);
  if (response.statusCode == 200)
  {
  var data =  jsonDecode(response.body);
  print("data"+data.toString());
    if(data!=null)
    {
      print("data2"+data['content']['rendered']);
      text=data['content']['rendered'];

    }
  }
  else if(response.statusCode==500 || response.statusCode==403)
  {

  }
  else {
    throw Exception('Failed to load album');
  }
}
}
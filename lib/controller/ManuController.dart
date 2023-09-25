import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/AllCategories/AllCategoriesModalClass.dart';
class MenuControllers extends GetxController{
  RxBool  loading=false.obs;
  BuildContext? context=Get.context;
  RxList<AllCategoriesModalClass> datass=<AllCategoriesModalClass>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allCategories();
  }
  //-----------------------load all categories-------------------

 void allCategories() async{
    loading.value=true;
    var urls="https://palrancho.co/wp-json/wc/v3/products?consumer_key=ck_0def1385963b008287e6d7aa1bff5a63f9a89880&consumer_secret=cs_bc192e77a03225f3bceef8d913c47692b0716869";
    print("url is location"+urls);
    final response = await http.get(Uri.parse(urls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200)
    {
        loading.value=false;
        List<dynamic> data=json.decode(response.body);
        print("data"+data.toString());
        data.map((e) {
          AllCategoriesModalClass datas = AllCategoriesModalClass.fromJson(e);
          datass.add(datas);
          print("futureCategoriewsdata" + datass.length.toString());
        }).toList();
    }
    else if (response.statusCode == 500 || response.statusCode==403 ) {
        loading.value=false;
        AllCategoriesModalClass data =  AllCategoriesModalClass.fromJson(jsonDecode(response.body));
        if(data!=null)
        {
            CommonUtilsClass.toastMessage("error");
        }
    }
    else {
      loading.value=false;
      throw Exception('Failed to load album');
    }
  }

}
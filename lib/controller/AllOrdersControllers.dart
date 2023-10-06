import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/model/AllOrder/OrderModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllOrdersController extends GetxController{
  var text="";
  RxBool isLoading=false.obs;
  RxList<AllOrdersModel> datass=<AllOrdersModel>[].obs;
  var  user_id="";
  RxBool datanotfound=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }
  void loadData() async{
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
   user_id = prefs.getString('user_id')?? "";
    if(user_id!="" && user_id!="null")
      {
        var url="https://palrancho.co/order_data.php?user_id=$user_id";
        print("urls"+url.toString());
        final response = await http.get(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },);
            if (response.statusCode == 200)
            {
              datass.clear();

              List<dynamic> data=json.decode(response.body);

              print("data"+data.toString());
              isLoading.value = false;
              if(data.isEmpty)
                {
                  datanotfound.value=true;
                }
              else {
                datanotfound.value=false;
                data.map((e) {
                  AllOrdersModel datas = AllOrdersModel.fromJson(e);
                  datass.add(datas);
                  print("futureCategoriewsdata" + datass.length.toString());
                }).toList();
              }
            }
            else if(response.statusCode==500 || response.statusCode==403)
            {
              isLoading.value=false;
              List<dynamic> jsonResponse = json.decode(response.body);
              print("json response"+jsonResponse.toString());
              CommonUtilsClass.toastMessage("Server side Error");
            }
            else {
              isLoading.value = false;
              throw Exception('Failed to load album');
            }
      }
    else
      {
        isLoading.value = false;
        Get.snackbar(
          "Please Login or Signup",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          borderRadius: 5,
          margin: EdgeInsets.all(5),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
  }
}
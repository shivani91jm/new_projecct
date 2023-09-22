import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/model/Login/LoginModelClass.dart';
class SignUpController extends GetxController{

  BuildContext? context=Get.context!;
  RxBool loading=false.obs;
  var latitude='';
  var longitude='';
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterEmail);
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.UserName);
    }
    return null;
  }
  String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.address);
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterPassword);
    }

    return null;
  }
  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterMoble);
    }
     if(value!.isEmpty && value.length!=10)
       {
         return CommonUtilsClass.toastMessage('Mobile Number must be of 10 digit');
       }

    return null;
  }
  bool isValidEmail(String email) {
    // Regular expression pattern for a basic email validation
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  void singUpApi(String name,String email,String password,String mobile,String address) async{
    loading.value=true;
    var urls=BaseUrlsClass.signUpUrls;
    print("url is location"+urls);
    var body=jsonEncode(<String, String>{
      'username': name,
      'password': password,
      'email': email,
      'mobile_number':mobile,
      'location': address,
      'latitude': latitude,
      'longitude': longitude
    });
    print("body"+body.toString());
    final response = await http.post(
        Uri.parse(urls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
     print("res"+response.body.toString());
    if (response.statusCode == 200)
    {
      loading.value=false;
      LoginModelClass data =  LoginModelClass.fromJson(jsonDecode(response.body));
      if(data!=null)
      {
        CommonUtilsClass.toastMessage(data.message.toString());
         Navigator.pushNamed(context!,RouteNames.location_screen);
      }
    }
    else if (response.statusCode == 500) {
      loading.value=false;
      LoginModelClass data=  LoginModelClass.fromJson(jsonDecode(response.body));
      print(""+data.toString());
      CommonUtilsClass.toastMessage("Server side Error");
    }
    else {
      loading.value=false;
      throw Exception('Failed to load album');
    }
  }


}
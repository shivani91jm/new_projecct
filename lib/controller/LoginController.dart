import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/model/Login/LoginModelClass.dart';
class LoginController extends GetxController {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  BuildContext? context=Get.context!;
  RxBool loading=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  String? validateEmail(String? value) {
    if (value!.isEmpty ) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterEmail);
    }
   // else if (!isValidEmail(value)) {
   //    return 'Please enter a valid email address';
   //  }
    return null;
  }
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterPassword);
    }

    return null;
  }
    //  validation( GlobalKey<FormState> formKey){
    //   if (formKey.currentState!.validate()) {
    //
    //     loginApi();
    //    // Navigator.pushNamed(context!,RouteNames.location_screen);
    //   }
    // }

  //================== proper validate email -------------
  bool isValidEmail(String email) {
    // Regular expression pattern for a basic email validation
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  loginApi() async{
    loading.value=true;
    var urls=BaseUrlsClass.loginUrls;
    print("url is location"+urls);
    var body=jsonEncode(<String, String>{
      'username': emailController.text,
      'password': passwordController.text
    });
    print("body"+body.toString());
    final response = await http.post(Uri.parse(urls),
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
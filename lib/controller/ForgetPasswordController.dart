import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:new_projecct/model/Login/LoginModelClass.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController editingController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  bool passwordsMatch = true;
  RxBool loading=false.obs;
 BuildContext? context=Get.context;
 var password=''.obs;
  //--------------validate email ---------------------
  void validation(GlobalKey<FormState> _formKey){
    if (_formKey.currentState!.validate()) {
      print("dhfjfjf");

    }
  }
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterEmail);
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  bool isValidEmail(String email) {
    // Regular expression pattern for a basic email validation
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  void checkEmailExitsOrNot(GlobalKey<FormState> _formKey) async {
    if (_formKey.currentState!.validate()) {
      loading.value=true;
      var urls="https://palrancho.co//wp-json/custom/v1/forget_password?";
      print("url is location"+urls);
      var body=jsonEncode(<String, String>{
        'email': editingController.text,
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
        ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response.body));
        if(data!=null)
        {
           CommonUtilsClass.toastMessage("Password reset link has been sent to your registered email.");
           Navigator.pushNamed(context!, RouteNames.login_screen);
        }
      }

      else {
        loading.value=false;
        throw Exception('Failed to load album');
      }
    }
  }
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterPassword);
    }

    return null;
  }
  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterConPassword);
    }

    return null;
  }
  //------------------------update password ---------------------
    void changePassword(String email) async{
      loading.value=true;
      var urls="https://palrancho.co/wp-json/custom/v1/update-password?";
      print("url is location"+urls);
      var body=jsonEncode(<String, String>{
        'email': email,
        'new_password': passwordController.text
      });
      print("body"+body.toString());
      final response = await http.post(Uri.parse(urls),
          headers: <String, String>
          {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      print("res"+response.body.toString());
      if (response.statusCode == 200)
      {
        loading.value=false;
        ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response.body));

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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/model/Login/LoginModelClass.dart';
import 'package:new_projecct/view/Widgets/CustomDialogBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void singUpApi(String first,String last,String email,String password,String mobile,String address) async
  {
    loading.value=true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var shopUrl= prefs.getString('shopUrl')??"";
    var urls=shopUrl+BaseUrlsClass.signUpUrls;

    print("url is location"+urls);
    var body=jsonEncode(<String, String>{
      'username': email,
      'password': password,
      'email': email,
      'mobile_number':mobile,
      'location': address,
      'latitude': latitude,
      'longitude': longitude,
      "first_name":first,
      "last_name": last.toString()

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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('user_id', data.userId.toString());
        await prefs.setString('username', data.userNicename.toString());
        await prefs.setString('mobile_number', data.mobileNumber.toString());
        await prefs.setString('user_profile', data.profilePicture.toString());
        await prefs.setString('user_firstName', data.first_name.toString());
        await prefs.setString('user_lastName', data.last_name.toString());
        showDialog(context: context!, builder: (BuildContext context){
          return  CustomDialogBox(title: "Registration successful",
            descriptions: "Registration successful",
            img: Image.asset(ImageUrls.check_url), okBtn: AppConstentData.ok
            , cancelBtn: AppConstentData.cancel, pagename: RouteNames.dashboard_screen,);

        }
        );
      }
    }
    else if (response.statusCode == 500) {
      loading.value=false;
      var  data=  jsonDecode(response.body);
      if(data['message']=="User already registered with this email")
        {
          CommonUtilsClass.toastMessage(data['message']);
          Navigator.pushNamed(context!, RouteNames.login_screen);
        }
      else {
          CommonUtilsClass.toastMessage("Server side Error");
      }
          print(""+data.toString());
    }
    else {
      loading.value=false;
      throw Exception('Failed to load album');
    }
  }


}
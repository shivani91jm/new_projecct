import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/model/Login/LoginModelClass.dart';
import 'package:new_projecct/view/Widgets/CustomDialogBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginController extends GetxController {

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
    // else if (isValidEmail(value)) {
    //   return CommonUtilsClass.toastMessage("Please enter a valid email address");
    //
    //  }

    return null;
  }
  RxString? validatePassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterPassword);
    }
    return null;
  }
  loginApi(String email, String password) async{
    loading.value=true;
    var urls=BaseUrlsClass.loginUrls;
    print("url is location"+urls);
    var body=jsonEncode(<String, String>{
      'username': email,
      'password': password
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
      LoginModelClass data =  LoginModelClass.fromJson(jsonDecode(response.body));
      if(data!=null)
      {
        loading.value=false;
        CommonUtilsClass.toastMessage(data.message.toString());

        //------------------------store data in local ---------------------
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          await prefs.setString('user_id', data.userId.toString());
          await prefs.setString('username', data.userNicename.toString());
          await prefs.setString('mobile_number', data.mobileNumber.toString());
          await prefs.setString('user_profile', data.profilePicture.toString());
        await prefs.setString('user_firstName', data.first_name.toString());
        await prefs.setString('user_lastName', data.last_name.toString());

          showDialog(context: context!, builder: (BuildContext context){
              return  CustomDialogBox(title: AppConstentData.Login,
                descriptions: AppConstentData.loginsucess,
                img: Image.asset(ImageUrls.check_url), okBtn: AppConstentData.ok
                , cancelBtn: AppConstentData.cancel,);
            }
        );
      }
    }
    else if (response.statusCode==403) {
      loading.value=false;
      var data=  jsonDecode(response.body);
      print(""+data.toString());
      var msg=  CommonUtilsClass.removeHtmlTags(data['message']);
      CommonUtilsClass.toastMessage(msg);
    }
    else if (response.statusCode == 500)
    {
      loading.value=false;
      CommonUtilsClass.toastMessage("Server side Error");
    }
    else {
      loading.value=false;
      throw Exception('Failed to load album');
    }
  }







}
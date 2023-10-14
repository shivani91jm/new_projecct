import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsController extends GetxController {
  RxBool  loading=false.obs;
  BuildContext? context=Get.context;
  void submitContactDetails(String name,String email,String subject) async{
    loading.value=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var shopUrl= prefs.getString('shopUrl')??"";
    var urls=shopUrl+BaseUrlsClass.contactusUrls;
    print("url is location"+urls);
    var body=jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'subject': subject
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
      ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response.body));

      if(data!=null)
      {
        CommonUtilsClass.toastMessage(data.message.toString());
        Navigator.pushNamed(context!,RouteNames.dashboard_screen);
      }
    }
    else if (response.statusCode == 500 || response.statusCode==403 ) {
      loading.value=false;
      ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response.body));
      if(data!=null)
      {
        CommonUtilsClass.toastMessage(data.message.toString());

      }
    }
    else {
      loading.value=false;
      throw Exception('Failed to load album');
    }
  }
  //-------------- user name controller -------------------
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.UserName);
    }

    return null;
  }
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterEmail);
    }

    return null;
  }
  String? validateMessage(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.msg);
    }
    return null;
  }
}
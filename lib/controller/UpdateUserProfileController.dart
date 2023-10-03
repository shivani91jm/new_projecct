import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:new_projecct/model/Login/LoginModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateUserProfileController extends GetxController
{
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  var user_id="";
  var first_name="";
  var last_name="";
  var profile_picture="";
  RxBool loading= false.obs;
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.enterPassword);
    }

    return null;
  }

  void userUpdate(String first_name,String last_name, String image_path) async{

    var url="https://palrancho.co/update_user.php";
    print("url is location"+url);
    var request = http.MultipartRequest('POST', Uri.parse(url));
   // request.files.add(await http.MultipartFile.fromPath('profile_picture', image_path));
    request.fields['user_id'] = user_id;
    request.fields['first_name'] = first_name;
    request.fields['last_name'] = last_name;
    var response = await request.send();
    print("data value"+response.toString());
    // if (response.statusCode == 200)
    // {
    //   ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response));
    //       if(data!=null)
    //       {
    //             loading.value=false;
    //             CommonUtilsClass.toastMessage(data.message.toString());
    //
    //             //------------------------store data in local ---------------------
    //             //     final prefs = await SharedPreferences.getInstance();
    //             //     // await prefs.setString('email', email);
    //             //     await prefs.setString('user_id', data.userId.toString());
    //             //     await prefs.setString('username', data.userNicename.toString());
    //             //     await prefs.setString('mobile_number', data.mobileNumber.toString());
    //             //     await prefs.setString('user_profile', data.profilePicture.toString());
    //       }
    //  }
    // else if (response.statusCode==403) {
    //   loading.value=false;
    //   var data=  jsonDecode(response.body);
    //   print(""+data.toString());
    //   var msg=  CommonUtilsClass.removeHtmlTags(data['message']);
    //   CommonUtilsClass.toastMessage(msg);
    // }
    // else if (response.statusCode == 500)
    // {
    //   loading.value=false;
    //   CommonUtilsClass.toastMessage("Server side Error");
    // }
    // else {
    //   loading.value=false;
    //   throw Exception('Failed to load album');
    // }

  }


}
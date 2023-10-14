import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:new_projecct/model/Login/LoginModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateUserProfileController extends GetxController
{
  TextEditingController firstController=TextEditingController();
  TextEditingController lastController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
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

  void userUpdate(String first_name,String last_name, String mobile,String image_path, String user_id) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final file = await http.MultipartFile.fromPath(
      'profile_picture', image_path,
    );


    loading.value=true;

    var shopUrl= prefs.getString('shopUrl')??"";
    var urls=shopUrl+BaseUrlsClass.updateprofileUrls;
    print("urls"+urls);
    final uri = Uri.parse(urls);

   //  // Create a new multipart request
     final request = http.MultipartRequest('POST', uri);
   //
   //  // Add the image file to the request
   //
    request.files.add(file);

    // Add other key-value data to the request
    request.fields['user_id'] = user_id;
    request.fields['first_name'] = first_name;
    request.fields['last_name'] = last_name;
    request.fields['mobile_number'] = mobile;


    // Send the request and get the response
    final response = await request.send();
    if (response.statusCode == 200) {
      loading.value=false;
      print('Image and data uploaded successfully');
      final responseBody = await response.stream.bytesToString();
      print('Image and data uploaded successfully');
      print('Response: $responseBody');
      LoginModelClass data =  LoginModelClass.fromJson(jsonDecode(responseBody));
      CommonUtilsClass.toastMessage(data.message.toString());
      if(data.message=="User updated successfully") {
        //------------------------store data in local ---------------------
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('user_id', data.userId.toString());
        await prefs.setString('username', data.userNicename.toString());
        await prefs.setString('mobile_number', data.mobileNumber.toString());
        await prefs.setString('user_profile', data.profilePicture.toString());
        await prefs.setString('user_firstName', data.first_name.toString());
      }
      await prefs.setString('user_lastName', data.last_name.toString());
    } else {
      loading.value=false;
      print('Failed to upload image and data');
    }

  }


}
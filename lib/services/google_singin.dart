import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:new_projecct/model/Login/LoginModelClass.dart';
import 'package:new_projecct/view/Widgets/CustomDialogBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GoogleSinginClass {
  static Future<void> signup(BuildContext context) async {
    RxBool loading=false.obs;
    final FirebaseAuth auth = FirebaseAuth.instance;
   // final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
      if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result != null) {
        loading.value=true;
      var userEmail=  user!.email;
      var userName=user.displayName;
        // controller.loginApi(userEmail!,userName!);
      var urls=BaseUrlsClass.loginUrls;
      print("url is location"+urls);
      var body=jsonEncode(<String, String>{
        'username': userEmail.toString(),
        'password': userName.toString()
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


          //------------------------store data in local ---------------------
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', data.userEmail.toString());
          await prefs.setString('user_id', data.userId.toString());
          await prefs.setString('username', data.userNicename.toString());
          await prefs.setString('mobile_number', data.mobileNumber.toString());
          await prefs.setString('user_profile', data.profilePicture.toString());
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

        var data=  jsonDecode(response.body);
        print(""+data.toString());
        if(data['message'].toString()=="Unknown email address. Check again or try your username.")
        {
          var urls=BaseUrlsClass.signUpUrls;
          print("url is location"+urls);
          var body=jsonEncode(<String, String>{
            'username': "",
            'password': userName.toString(),
            'email': userEmail.toString(),
            'mobile_number':"",
            'location': "",
            'latitude': "",
            'longitude': ""
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

            LoginModelClass data =  LoginModelClass.fromJson(jsonDecode(response.body));
            if(data!=null)
            {
                CommonUtilsClass.toastMessage(data.message.toString());
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', data.userEmail.toString());
                await prefs.setString('user_id', data.userId.toString());
                await prefs.setString('username', data.userNicename.toString());
                await prefs.setString('mobile_number', data.mobileNumber.toString());
                await prefs.setString('user_profile', data.profilePicture.toString());

            }
          }
          else if(response.statusCode==403)
            {
              var data=  jsonDecode(response.body);
              var msg=  CommonUtilsClass.removeHtmlTags(data['message']);
              CommonUtilsClass.toastMessage(msg);
            }
          else if (response.statusCode == 500) {

            LoginModelClass data=  LoginModelClass.fromJson(jsonDecode(response.body));
            print(""+data.toString());
            CommonUtilsClass.toastMessage("Server side Error");
          }
          else {

            throw Exception('Failed to load album');
          }
        }

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
  }

}

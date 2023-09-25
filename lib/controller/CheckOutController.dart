import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutController extends GetxController {
  BuildContext? context=Get.context;
  var text;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //checkoutOrder();
  }
  void checkoutOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var emails=   prefs.getString('email')?? "";
   var username = prefs.getString('username')?? "";
   var usermobile = prefs.getString('mobile_number')?? "";
   var firstname=username;
    var last_name="";
    var address_1="i block ";
    var address_2="guajini ";
    var city="kanpur nagar";
    var state="utter pradesh";
    var postcode="208022";
    var country="india";
    var email=emails;
    var phone=usermobile;
    var product_id="[2410,469]";
    var quantity="[3,5]";
    var payment_method="basic";
    var payment_method_title="online payment";
    var set_paid="true";
    var user_id="251";
    var url= "https://websitedemoonline.com/iytastaging/create_order.php?first_name='$firstname'&last_name='$last_name'&address_1='$address_1'&address_2='$address_2'&city='$city'&state='$state'&postcode='$postcode'&country='$country'&email='$email'&phone='$phone'&product_data='$product_id'&quantity='$quantity'&payment_method='$payment_method'&payment_method_title='$payment_method_title'&set_paid='$set_paid'&user_id='$user_id";
    //var url="https://websitedemoonline.com/iytastaging/create_order.php?product_data=[2410,469]&user_id=1&first_name=fdsfdsf&last_name=dfdfdsf&address_1=123 Main St&city=New york&state=ny&postcode=10001&country=us&email=abc@gmail.com&phone=123456789&quantity=[3,4]";
    print("url"+url.toString());
    final response = await http.get(Uri.parse(url),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);
      print("response"+response.body.toString());
      if (response.statusCode == 200)
      {
        ContactUsModel data =  ContactUsModel.fromJson(jsonDecode(response.body));
        if(data!=null)
        {
            CommonUtilsClass.toastMessage(""+data.message.toString());
            Navigator.pushNamed(context!, RouteNames.dashboard_screen);
        }
      }
      else if(response.statusCode==500 || response.statusCode==403)
      {
         CommonUtilsClass.toastMessage("Server Side Error");
      }
     else {
        throw Exception('Failed to load album');
     }
  }

}
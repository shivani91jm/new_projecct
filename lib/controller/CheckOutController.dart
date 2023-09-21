import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';

class CheckOutController extends GetxController {
  BuildContext? context=Get.context;
  var text;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkoutOrder();
  }
  void checkoutOrder() async {
    var firstname="shivi";
    var last_name="singh";
    var address_1="i block ";
    var address_2="guajini ";
    var city="kanpur nagar";
    var state="utter pradesh";
    var postcode="208022";
    var country="india";
    var email="sh@gmail.com";
    var phone="8887885012";
    var product_id="496";
    var quantity="1";
    var payment_method="basic";
    var payment_method_title="online payment";
    var set_paid="true";
   // var url= "https://websitedemoonline.com/iytastaging/create_order.php?first_name='$firstname'&last_name='$last_name'&address_1='$address_1'&address_2='$address_2'&city='$city'&state='$state'&postcode='$postcode'&country='$country'&email='$email'&phone='$phone'&product_id='$product_id'&quantity='$quantity'&payment_method='$payment_method'&payment_method_title='$payment_method_title'&set_paid='$set_paid";

    //var url="https://palrancho.co/wp-json/wp/v2/pages/11159";
    var url="https://websitedemoonline.com/iytastaging/create_order.php?first_name=shi&last_name=demofds&address_1=testting%20demodff&city=knp&state=uttar&postcode=208019&country=in&email=shivani%40techindiasoftware.com&phone=9807000990&product_ids[]=2410&quantities[]=4&product_ids[]=496&quantities[]=3&payment_method=bacs&payment_method_title=&set_paid=true&user_id=1";
    print("url"+url.toString());
    final response = await http.get(Uri.parse(url), headers: <String, String>{
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
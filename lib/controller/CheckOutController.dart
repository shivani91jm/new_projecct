import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutController extends GetxController {
  BuildContext? context=Get.context;
  var text;
  RxBool loading = false.obs;
  List<int> product_ids=[];
  List<int> product_quentity=[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getValue();

  }
  void checkoutOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
       var emails=   prefs.getString('email')?? "";
       var username = prefs.getString('username')?? "";
       var usermobile = prefs.getString('mobile_number')?? "";
       var type= prefs.getString('type')??"";
      var falt=  prefs.getString("flat")??"";
        var area=prefs.getString("area")??"";
       var house= prefs.getString("houseno" )??"";
      var nearby=  prefs.getString("nearby")??"";
        var address="";
       var firstname="shivani";
        var last_name="singh";
        var address_1="i block ";
        var address_2="guajini ";
        var city="kanpur nagar";
        var state="utter pradesh";
        var postcode="208022";
        var country="india";
        var email="shivani@techindi.con";
        var phone="77777777777";

        var payment_method="basic";
        var payment_method_title="online payment";
        var set_paid="true";
        var user_id="251";
        final List<String> queryParams = [];

        for(int i=0;i<product_ids.length;i++)
       {
           queryParams.add('product_data[$i][product_id]=${product_ids[i]}');
       }
      for( int i=0;i<product_quentity.length;i++)
      {
           queryParams.add('product_data[$i][quantity]=${product_quentity[i]}');
      }
     print("dfgfdg"+queryParams.toString());
    final baseUrl = 'https://palrancho.co/create_order.php';
    final Uri uri = Uri.parse('$baseUrl?'
        'first_name=$firstname'
        '&last_name=$last_name'
        '&address_1=$address'
        '&address_2=$address_2'
        '&city=$city'
        '&state=$state'
        '&postcode=$postcode'
        '&country=$country'
        '&email=$email'
        '&phone=$phone'
        '&payment_method=$payment_method'
        '&payment_method_title=$payment_method_title'
        '&set_paid="true'
        '&user_id=$user_id'
        '&${queryParams.join('&')}');
     print("url"+uri.toString());

    final response = await http.get(uri,
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
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

  void getValue() async{
    print("fdgdsfhgsdhfshfj");
    DatabaseHelper? dbHelper = DatabaseHelper();
     var cart = await dbHelper.getCartList();

      for(int i=0;i<cart.length;i++)
       {
         var product_id=cart[i].productId;
         var quantity=cart[i].quantity;
         product_ids.add(int.parse(product_id.toString()));
         product_quentity.add(quantity);

       }

      }

  }


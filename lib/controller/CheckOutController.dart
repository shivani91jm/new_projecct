import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CartProvider.dart';

import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ContactUs/ContactUsModel.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/CustomDialogBox.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CheckOutController extends GetxController {
  BuildContext? context=Get.context;
  var text;
  RxBool loading = false.obs;
  List<int> product_ids=[];
  List<int> product_quentity=[];
   DatabaseHelper? dbHelper = DatabaseHelper();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    context!.read<CartProvider>().getData();
    getValue();
  }
  void checkoutOrder(CartProvider cart) async {
    loading.value=true;
    print("fdgdsfhgsdhfshfj");
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
       email=   prefs.getString('email')?? "";
        var username = prefs.getString('username')?? "";
        phone = prefs.getString('mobile_number')?? "";
        city =  prefs.getString('city')??"";
        state= prefs.getString('state')??"";
        postcode= prefs.getString('postcode')??"";
         country=prefs.getString('country')??"";
        address_1= prefs.getString('address_1')??"";
        address_2= prefs.getString('address_2')??"";
        user_id= prefs.getString('user_id')??"";
        firstname= prefs.getString('user_firstName')??"";
        last_name= prefs.getString('user_lastName')??"";
        print("data_value"+"email"+email+"phone"+phone+"city"+city+"state"+state+"postcode"+postcode+"country"+country+"address1:"+address_1+"address2:"+address_2);
        print("user_id"+user_id+"firstname"+firstname+"last name"+last_name);
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
    var shopUrl= prefs.getString('shopUrl')??"";
    final baseUrl=shopUrl+"/create_order.php";

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
                  print("sucess"+data.message.toString());
                  loading.value=false;
                    CommonUtilsClass.toastMessage(""+data.message.toString());
                   showDialog(context: context!, builder: (BuildContext context){
                    return  CustomDialogBox(title: "Success",
                      descriptions: "Place Order Successfully",
                      img: Image.asset(ImageUrls.check_url), okBtn: AppConstentData.ok
                      , cancelBtn: AppConstentData.cancel, pagename: RouteNames.allOrders_screen,);

                    }
                  );

                  List<CartModelClass> postsFuture =await cart.getData();
                  for(int i=0;i<postsFuture.length;i++)
                    {
                      dbHelper!.deleteCartItem(int.parse(postsFuture[i].productId.toString()));
                      cart.removeCounter();
                      cart.removeTotalPrice(double.parse(postsFuture[i].productPrice.toString()));
                    }



                }
            }
            else if(response.statusCode==500 || response.statusCode==403)
            {
              loading.value=false;
               CommonUtilsClass.toastMessage("Server Side Error");
            }
           else {
              loading.value=false;
              throw Exception('Failed to load album');
           }
  }
  void getValue() async{
    print("fdgdsfhgsdhfshfj");

     var cart = await dbHelper!.getCartList();
     for(int i=0;i<cart.length;i++)
       {
         var product_id=cart[i].productId;
         var quantity=cart[i].quantity;
         product_ids.add(int.parse(product_id.toString()));
         product_quentity.add(quantity);

       }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // context!.read<CartProvider>().dispose();
  }


  void processPayment() async {
    String endpoint = 'https://apisandbox.dev.clover.com/v3/merchants/PPSP55WHHYYV1/orders'; // Replace with your endpoint

    Map<String, String> headers = {
      'Authorization': 'Bearer 2f9b0b6d-6180-4fa7-2936-673e5b8facad',
      'Content-Type': 'application/json',
    };
    final orderData = {
      "total": 5000, // Replace with the total amount of the order.
      "state": "open",
      'currency': 'USD',

    };
    String jsonData = json.encode(orderData);
    var response = await http.post(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 2a88f2a3-1715-417e-c85d-1b8b38954d38',
    }, body: jsonData);
    print("data"+response.body.toString());
    if (response.statusCode == 200) {
      print("data"+response.body.toString());
      //var response=jsonDecode(response.body);
    } else {
      print("data"+response.body.toString());
    }




  }
  
}






import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:new_projecct/model/AllCategories/Categories.dart';
import 'package:new_projecct/model/CategoriesByIdModel/CategoriesModelByIdClass.dart';
import 'package:new_projecct/model/dynamicproduct/prouct_dynamic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  final PageController pageController = PageController();
  var currentIndex = 0.obs;
  RxString cat_id="121".obs;
  RxList<Category> futureCategoriews=<Category>[].obs;
  RxString prodctCatName="Food Category".obs;
  RxBool productFlag=false.obs;
  RxBool isLoading=false.obs;
  String shopUrl="",shopConsumerKey='',ShopConsumerScreate="";
  RxList<String> titleList=<String>[].obs;
  RxList<CategoriesByIdModelClass> datass=<CategoriesByIdModelClass>[].obs;
  Timer? _timer;
  RxList<Categories> catList=<Categories>[].obs;
//-------------------slider create -----------------------

  @override
 void onInit() {
   // TODO: implement onInit
   super.onInit();
   // _timer = Timer.periodic(Duration(seconds: 3), (timer) {
   //   if (currentIndex.value < sliderimageUrls.length - 1) {
   //     currentIndex++;
   //   }
   //   else {
   //     currentIndex.value = 0;
   //   }
   //   pageController.animateToPage(currentIndex.value,
   //     duration: Duration(milliseconds: 500),
   //     curve: Curves.easeInOut,
   //   );
   // });
  // getStoreData();
   loadCatProductIDWise();
   allCategories();

 }
  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

 @override
 void onReady() {
   // TODO: implement onReady
   super.onReady();
 }

  void allCategories() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopUrl= prefs.getString('shopUrl')??"";
    shopConsumerKey=prefs.getString("shop_consumer_key")??"";
    ShopConsumerScreate=  prefs.getString("shop_consumer_secrete")??"";
    var urls=shopUrl+"/wp-json/wc/v3/products/categories?consumer_key=$shopConsumerKey&consumer_secret=$ShopConsumerScreate";
    print("url is location"+urls);
    final response = await http.get(Uri.parse(urls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200)
    {

        List<dynamic> data=json.decode(response.body);
        print("data"+data.toString());
        data.map((e) {
          Categories datas = Categories.fromJson(e);
          catList.add(datas);
          print("futureCategoriewsdata" + catList.length.toString());
        }).toList();

    }
    else if (response.statusCode == 500 || response.statusCode==403 ) {

      Categories data =  Categories.fromJson(jsonDecode(response.body));
      if(data!=null)
      {
        CommonUtilsClass.toastMessage("error");
      }
    }
    else {
      throw Exception('Failed to load album');
    }
  }

  void loadCatProductIDWise() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   shopUrl= prefs.getString('shopUrl')??"";
   shopConsumerKey=prefs.getString("shop_consumer_key")??"";
   ShopConsumerScreate=  prefs.getString("shop_consumer_secrete")??"";
  prefs.getString("shop_name");
  print("shop url"+shopUrl.toString()+"shop consumer key"+shopConsumerKey.toString()+"shop consumer secrete"+ShopConsumerScreate.toString());
   isLoading.value=true;
   var urls=shopUrl+BaseUrlsClass.catProdUrls;
   print("url is location"+urls);
    final response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      isLoading.value = false;
        List<dynamic> data=json.decode(response.body);
        print("data"+data.toString());
        data.map((e) {
          Category datas = Category.fromJson(e);
          futureCategoriews.add(datas);
          // dynamicModel dat=dynamicModel.fromJson(data,)
          print("futureCategoriewsdata" + datass.length.toString());
          productFlag = true.obs;

        }).toList();
      print("futureCategoriews" + futureCategoriews.length.toString());
    }
    else if (response.statusCode == 500) {
      isLoading.value=false;
      List<dynamic> jsonResponse = json.decode(response.body);
      print("json response"+jsonResponse.toString());
      CommonUtilsClass.toastMessage("Server side Error");
    }
    else {
      isLoading.value=false;
      //throw Exception('Failed to load album');
    }

 }


}
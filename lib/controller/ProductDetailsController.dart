import 'dart:convert';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/model/ProductDetails/ProductDetailsModel.dart';
import 'package:new_projecct/model/ProductDetails/RecentProductDetails/RecentProductDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ProductDetailsController extends GetxController{
  var shopUrl='',shopConsumerKey='',ShopConsumerScreate='';
  RxBool isLoading=false.obs;
  RxString productId='169'.obs;
   ProductDetailsModel model=ProductDetailsModel();
  RxList<RecentProductsDetails> recentProduct=<RecentProductsDetails>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadProduct();
    RecentProduct();

  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void loadProduct() async{
    isLoading.value=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
     shopUrl= prefs.getString('shopUrl')!;
     shopConsumerKey=prefs.getString("shop_consumer_key")!;
     ShopConsumerScreate=  prefs.getString("shop_consumer_secrete")!;
    // prefs.getString("shop_name");
   // var urls= "https://palrancho.co/wp-json/wc/v3/products/"+productId.value+"?consumer_key=ck_0def1385963b008287e6d7aa1bff5a63f9a89880&consumer_secret=cs_bc192e77a03225f3bceef8d913c47692b0716869";
    var urls= shopUrl+"/wp-json/wc/v3/products/"+productId.value+"?consumer_key="+shopConsumerKey+"&consumer_secret="+ShopConsumerScreate;
    print("url is location"+urls);
    final response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      isLoading.value = false;
       model=ProductDetailsModel.fromJson(json.decode(response.body));
      print("data"+model!.attributes.toString());
    }
    else if (response.statusCode == 500) {
      isLoading.value=false;
      ProductDetailsModel model=ProductDetailsModel.fromJson(json.decode(response.body));
      print("data"+model.attributes.toString());
      CommonUtilsClass.toastMessage("Server side Error");
    }
    else {
      isLoading.value=false;
      //throw Exception('Failed to load album');
    }
  }
  void RecentProduct() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     shopUrl= prefs.getString('shopUrl')??"";
     shopConsumerKey=prefs.getString("shop_consumer_key")??"";
     ShopConsumerScreate=  prefs.getString("shop_consumer_secrete")??"";
     prefs.getString("shop_name");
    var urls= shopUrl+"/wp-json/custom/v1/related-products/"+productId.value;
  //  var urls= "https://palrancho.co/wp-json/custom/v1/related-products/"+productId.value;
    print("recent url is location"+urls);
    final response = await http.get(Uri.parse(urls));
    print("response"+response.body.toString());
    if (response.statusCode == 200) {
      recentProduct.clear();
      isLoading.value = false;
      List<dynamic> lists = json.decode(response.body);
      for(int i=0;i<lists.length;i++)
        {
          print("data lisy"+lists.toString());
          RecentProductsDetails productsDetails= RecentProductsDetails.fromJson(lists[i]);
          recentProduct.add(productsDetails);
        }
       print("data"+recentProduct!.length.toString());
    }
    else if (response.statusCode == 500) {
      isLoading.value=false;
      List<dynamic> list = json.decode(response.body);
    //  print("data"+list.toString());
      CommonUtilsClass.toastMessage("Server side Error");
    }
    else {
      isLoading.value=false;
      throw Exception('Failed to load album');
    }
  }

}
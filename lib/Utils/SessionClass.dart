import 'package:shared_preferences/shared_preferences.dart';

class SessionClass{

  void  addToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
  void getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("token");
  }
 void  addEmail(String email) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
  void getEmail() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('email');
  }
  void addUserName(String username) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }
  void getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('email');
  }
  void addMobileNumber(String mobile) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobile);
  }
  void getMobile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('mobile');
  }
     static addShopUrl(String shopUrl) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('shopUrl', shopUrl);
  }
   static Future<String?> getShopUrl() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getString('shopUrl');
  }
  static  addShopConsumerKey(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('consumer_key', data);
  }
  static  getShopConsumerKey() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('consumer_key');
  }
  static   getShopConsumerSecret() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('consumer_secret');
  }
  static void  addShopConsumerSecret(String consumer_secret) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('consumer_secret',consumer_secret);
  }
  static  addShopName(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('shop_name', data);
  }
  static void  getShopName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('shop_name');
  }





}
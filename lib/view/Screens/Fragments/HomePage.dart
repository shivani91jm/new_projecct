 // import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/CheckInternetController.dart';
import 'package:new_projecct/controller/HomeController.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/HomeAppBar.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sqflite/sqflite.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  HomeController controller= Get.put(HomeController());
  DatabaseHelper? databaseHelper=DatabaseHelper();
  String getCurrentLocation="";
  PageController _pageController = PageController();
  final CheckInternetController _controller = Get.find<CheckInternetController>();
  int _currentPage = 0;

  @override
  void initState() {
    _gotoCurrentPostion();
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }
  //--------------------current location -----------------------
  Future _gotoCurrentPostion() async{
    Position currentPostion= await _determainUserCurrentPostion();
    _gotoSepPostion(LatLng(currentPostion.latitude, currentPostion.longitude));
  }
  Future _determainUserCurrentPostion() async{
    LocationPermission locationPermission;
    bool isLocationOn=await Geolocator.isLocationServiceEnabled();
    if(!isLocationOn)
    {
      CommonUtilsClass.toastMessage("User don't enable location Permission");
    }
    locationPermission =await Geolocator.checkPermission();
    if(locationPermission==LocationPermission.denied)
    {
      locationPermission=await Geolocator.requestPermission();
      CommonUtilsClass.toastMessage("user denied location permission");
    }
    if(locationPermission==LocationPermission.deniedForever)
    {
      CommonUtilsClass.toastMessage("user denied  permission forever");
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
  Future _gotoSepPostion(LatLng postion) async{
    await _getAddress(postion);
  }
  Future _getAddress(LatLng position) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark place=placemarks[0];
    String address = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode},${place.country}';
    print("address"+address.toString());
    setState(() {
      prefs.setString("currentLocation", address);
      getCurrentLocation= prefs.getString("currentLocation")!;

    });
  }
  @override
  Widget build(BuildContext context) {
   return RefreshIndicator(
      displacement: 250,
      backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
       controller.loadCatProductIDWise();
      },
      child: Obx(() => _controller.connectionType.value == 1 ? datawiget() : _controller.connectionType.value == 2 ?  datawiget() : NoInternetClass(page: RouteNames.dashboard_screen,))
   );

  }
  Widget datawiget(){
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeAppBar(currentLocation: getCurrentLocation.toString(),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context!,RouteNames.addtocart_screen);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(4, 0, 30, 0),
                    child: badges.Badge(
                      badgeAnimation: badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                      ),
                      badgeContent: Consumer<CartProvider>(
                        builder: (context,value,child){
                          return Text(value.getCounter().toString(),style: TextStyle(
                              color: AppColors.whiteColors
                          ),);
                        },
                      ),
                      child: Icon(Icons.shopping_cart_checkout,color: AppColors.whiteColors,),
                    ),
                  ),
                )
              ],)],),
        body: Obx(() => controller.isLoading.value?  Center(child: CircularProgressIndicator(
          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : HomeData()));
  }
  Widget HomeData(){
   return SingleChildScrollView(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         //----------------------- custom app bar -------------------
         SliderWidiget(),
         SizedBox(
           height: 20,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
               child:Text("CATEGORIES",
                 style: TextStyle(
                   fontSize: AppSizeClass.maxSize20,
                   fontWeight: FontWeight.bold,

                   color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
               child:Align(
                 alignment: Alignment.centerRight,
                 child: Text("View All",
                   style: TextStyle(
                     fontSize: AppSizeClass.maxSize12,
                     fontWeight: FontWeight.bold,
                       color: AppColors.greyColors
                   ),
                   ),
                 ),
               ),

           ],
         ),
         showAllCategories(),
         //---------------product data -----------------------
         homeProduct(),
         SizedBox(
           height: 20,
         ),
       ],
     ),
   );
  }
  Widget SliderWidiget() {
    return Container(
      width:  MediaQuery.of(context).size.width,
      height: 230,
        margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnotherCarousel(
            images: [
              NetworkImage('https://palrancho.co/wp-content/uploads/2014/08/32-1.jpg'),
              NetworkImage('https://palrancho.co/wp-content/uploads/2014/08/56.jpg'),
              NetworkImage('https://palrancho.co/wp-content/uploads/2014/08/PalRancho_Choripapitas_2880x2304-scaled.jpg'),
            ],
            dotSize: 6.0,
            dotSpacing: 15.0,
            dotColor:  GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
            indicatorBgPadding: 5.0,
            dotBgColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR).withOpacity(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  width: 280,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.6),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(10.0,20,10,10.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('WELCOME TO PAL RANCHO',
                            style: TextStyle(fontSize: 20.0,
                                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                fontWeight: FontWeight.bold,

                            ),
                          ),
                          Text(
                            'Delicious Food & Wonderful Eating Experience',
                            style: TextStyle(fontSize: 15.0,
                                color: AppColors.blackColors,
                                fontWeight: FontWeight.w400,

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.fromLTRB(12,8.0,12.0,8.0),
                              child: Text(
                                'Find My Store',
                                style: TextStyle(fontSize: 14.0,
                                    color: AppColors.whiteColors,
                                    fontWeight: FontWeight.w200,



                                ),
                              ),
                            ),)

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
 Widget homeProduct() {
   final cart =Provider.of<CartProvider>(context);
      return  Container(
        margin: EdgeInsets.fromLTRB(0,0,5,0),
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.futureCategoriews.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:Text(controller.futureCategoriews[index].name.toString(),
                      style: TextStyle(
                          fontSize: AppSizeClass.maxSize20,
                          fontWeight: FontWeight.bold,

                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 280,
                    child:  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:controller.futureCategoriews[index].products!.length,
                        itemBuilder: (context,cat_in){
                          var data=controller.futureCategoriews[index].products![cat_in];
                          return  Container(
                        height: MediaQuery.of(context).size.height*0.5,
                         child: GestureDetector(
                           onTap: () async{
                             var id=data.id;
                             var name=data.name.toString();
                             var imgae="";
                             if(data.image!=false)
                             {
                               imgae=data.image.toString();
                             }
                             else
                             {
                               imgae= "https://palrancho.co/wp-content/uploads/2014/08/32-1.jpg";
                             }
                             Navigator.pushNamed(context, RouteNames.productdetails_screen,arguments: {
                               "product_id":id,
                               "product_name":name,
                               "product_image": imgae,
                               "product_price": data.price.toString()
                             });
                           },
                      child: Container(
                       child: Card(
                         elevation: AppSizeClass.maxSize10,
                           clipBehavior: Clip.hardEdge,
                         child: Column(
                           children: [
                             if(data.image!=false)...
                             {
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),
                                 child: Card(
                                   elevation: AppSizeClass.maxSize3,
                                   clipBehavior: Clip.hardEdge,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15.0),
                                   ),
                                   child: Container(
                                     width: 160,
                                     height: 160,
                                     child: Image.network(data.image.toString(),fit: BoxFit.cover,),
                                   ),
                                 ),
                               ),
                             }
                             else...
                             {
                               Card(
                                 elevation: AppSizeClass.maxSize3,
                                 clipBehavior: Clip.hardEdge,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Container(
                                   width: 160,
                                   height: 160,
                                   child: Image.network("https://palrancho.co/wp-content/uploads/2014/08/32-1.jpg", fit: BoxFit.cover,),
                                 ),
                               ),
                             },
                             SizedBox(
                               height: 10,
                             ),
                             Expanded(
                               child: Container(
                                   padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),
                                   width: 170,
                                   child: Text(""+data.name.toString(),style: TextStyle(
                                     color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),

                                     fontSize: AppSizeClass.maxSize14,
                                     fontWeight: FontWeight.bold,
                                   ),)
                               ),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                   Align(
                                   alignment: Alignment.topLeft,
                                   child: Container(
                                       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                       padding: EdgeInsets.fromLTRB(8, 0, 0, 10),
                                       child: Text('' r"$"+data.price.toString(),style: TextStyle(
                                         color:GradientHelper.getColorFromHex(AppColors.RED_COLOR) ,

                                         fontSize: AppSizeClass.maxSize18,
                                         fontWeight: FontWeight.bold,

                                       ),)
                                   ),
                                 ),
                                   Align(
                                 alignment: Alignment.topRight,
                                 child:   Container(

                                   margin: EdgeInsets.fromLTRB(50, 0, 10, 10),
                                   child: Padding(
                                     padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                     child: CircleAvatar(
                                       backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                       child: IconButton(
                                         onPressed: () async
                                         {
                                           var id=data.id.toString();
                                           var name=data.name.toString();
                                           var imgae="";
                                           if(data.image!=false)
                                           {
                                             imgae= data.image.toString();
                                           }
                                           else
                                           {
                                             imgae= "https://palrancho.co/wp-content/uploads/2020/03/Papa-Cocida.png";
                                           }
                                           Navigator.pushNamed(context, RouteNames.addtocart_screen);
                                           databaseHelper!.insert(
                                               CartModelClass(
                                                   // id: cat_in,
                                                   productId: data.id.toString(),
                                                   productName: data.name,
                                                   productDetails: data.content,
                                                   initilPrice: double.parse(data.price.toString()),
                                                   productPrice: double.parse(data.price.toString()),
                                                   quantity: 1,
                                                   image: imgae
                                               )
                                           ).then((value)  {
                                             print("add product added");
                                             cart.addTotalPrice(double.parse(data.price.toString()));
                                             cart.addCounter();
                                             Get.snackbar(
                                               "Add product added cart.",
                                               "",
                                               snackPosition: SnackPosition.BOTTOM,
                                               backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                               borderRadius: 5,
                                               margin: EdgeInsets.all(5),
                                               colorText: Colors.white,
                                               duration: Duration(seconds: 4),
                                               isDismissible: true,

                                               forwardAnimationCurve: Curves.easeOutBack,
                                             );
                                           }).onError((error, stackTrace) {
                                             print("erorr"+error.toString());
                                             if (error is DatabaseException && error.isUniqueConstraintError()) {
                                         //      // Handle the UNIQUE constraint error here
                                              Get.snackbar(
                                                "Product already exists in the cart.",
                                                "",
                                                snackPosition: SnackPosition.BOTTOM,
                                                backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                                borderRadius: 5,
                                                margin: EdgeInsets.all(5),
                                                colorText: Colors.white,
                                                duration: Duration(seconds: 4),
                                                isDismissible: true,

                                                forwardAnimationCurve: Curves.easeOutBack,

                                              );

                                              print("Product already exists in the cart.");
                                            }



                                           });

                                         },
                                         icon: Icon(Icons.shopping_cart,color: AppColors.whiteColors,
                                         ),

                                       ),
                                     ),
                                   ),
                                 ),
                               )
                               ],
                             )



                   ],
                 ),
                         ),
                     ),
                  ),
               );
                        }),
                  )
                ]
            );
          },
        ),
      );
  }
  Widget showAllCategories() {
    return  Obx(() => Container(
      height: 80,
      margin: EdgeInsets.fromLTRB(10,0,10,0),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.catList!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async{
              Navigator.pushNamed(context, RouteNames.categories_by_screen,arguments: {
                  "cat_name":controller.catList[index].name.toString(),
                  "cat_id":controller.catList[index].id.toString()
                });
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Card(
                    clipBehavior: Clip.hardEdge,
                    color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:Center(
                        child: Text(controller.catList[index].name.toString(),
                          style: TextStyle(
                            fontSize: AppSizeClass.maxSize14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColors,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]
            ),
          );
        },
      ),
    ));
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/HomeController.dart';
import 'package:new_projecct/database/db_helper.dart';

import 'package:new_projecct/view/Widgets/ImageSliderItem.dart';
import 'package:provider/provider.dart';
import '../../../Utils/AppContstansData.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  HomeController controller= Get.put(HomeController());
  DatabaseHelper? databaseHelper=DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: ,
        //   actions: [
        //     GestureDetector(
        //       onTap: (){
        //         Navigator.pushNamed(context!,RouteNames.addtocart_screen);
        //       },
        //       child: Container(
        //         margin: EdgeInsets.fromLTRB(4, 0, 30, 0),
        //         child: badges.Badge(
        //           badgeAnimation: badges.BadgeAnimation.rotation(
        //             animationDuration: Duration(seconds: 1),
        //             colorChangeAnimationDuration: Duration(seconds: 1),
        //             loopAnimation: false,
        //             curve: Curves.fastOutSlowIn,
        //             colorChangeAnimationCurve: Curves.easeInCubic,
        //           ),
        //           badgeStyle: badges.BadgeStyle(
        //             shape: badges.BadgeShape.circle,
        //             badgeColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
        //           ),
        //           badgeContent: Consumer<CartProvider>(
        //             builder: (context,value,child){
        //               return Text(value.getCounter().toString(),style: TextStyle(
        //                   color: AppColors.whiteColors
        //               ),);
        //             },
        //           ),
        //           child: Icon(Icons.shopping_cart_checkout,color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: Obx(() => controller.isLoading.value?  Center(child: CircularProgressIndicator(
          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
        ),
        ) : HomeData()))

      );

  }
  Widget HomeData(){
   return SingleChildScrollView(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         //----------------------- custom app bar -------------------

         //----------------------create slider -----------------------
         SliderWidiget(),
         SizedBox(
           height: 20,
         ),
         homeProduct(),
         SizedBox(
           height: 20,
         ),

       ],
     ),
   );
  }
  Widget SliderWidiget() {
    // return Container(
    //   width:  double.infinity,
    //   height: MediaQuery.of(context).size.height*0.3,
    //   child:  Obx(() =>  CarouselSlider.builder(
    //     options: CarouselOptions(
    //       height: MediaQuery.of(context).size.height*0.3,
    //       autoPlay: true,
    //     ),
    //     itemCount: controller.sliderimageUrls.length,
    //     itemBuilder: (context, itemIndex, realIndex)
    //     {
    //       return Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Card(
    //           elevation: AppSizeClass.maxSize10,
    //           clipBehavior: Clip.hardEdge,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10.0),
    //           ),
    //           child: Stack(
    //             children:[
    //
    //               SizedBox(height: 20),
    //               Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Image.network(controller.sliderimageUrls[itemIndex].toString(),
    //                   width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
    //               )
    //             ] ,
    //           ),
    //         ),
    //       );
    //     },
    //   ),),
    // );
    return GetX<HomeController>(builder: (controller){
     return Container(
       height: MediaQuery.of(context).size.height *0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: PageView.builder(
          itemCount: controller.sliderimageUrls.length,
          itemBuilder: (context, index) {
            return ImageSliderItem(imagePath: controller.sliderimageUrls[index]);
          },
        ),
      );
    });
 }
 Widget  homeProduct() {
   final cart =Provider.of<CartProvider>(context);
      return  ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.futureCategoriews.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                  child:Text(controller.futureCategoriews[index].name.toString(),
                    style: TextStyle(
                        fontSize: AppSizeClass.maxSize20,
                        fontWeight: FontWeight.bold,
                      fontFamily: "NotoSerif",
                      color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
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
                       imgae= "https://palrancho.co/wp-content/uploads/2020/03/Papa-Cocida.png";
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
                                 clipBehavior: Clip.hardEdge,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0),
                                 ),
                                 child: Container(
                                   width: 180,
                                   height: 180,
                                   child: Image.network(data.image.toString(),fit: BoxFit.cover,),
                                 ),
                               ),
                             ),
                           }
                           else...
                           {
                             Card(
                               elevation: AppSizeClass.maxSize10,
                               clipBehavior: Clip.hardEdge,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(15.0),
                               ),
                               child: Container(
                                 width: 180,
                                 height: 150,
                                 child: Image.network("https://palrancho.co/wp-content/uploads/2020/03/Papa-Cocida.png", fit: BoxFit.cover,),
                               ),
                             ),
                           },
                           SizedBox(
                             height: 10,
                           ),
                           if(data.name!="null")...
                           {
                             Container(
                                 width: 180,
                                 height:80,
                                 child: Text(""+data.name.toString(),style: TextStyle(
                                   color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                   fontFamily: "NotoSerif",
                                   fontSize: AppSizeClass.maxSize14,
                                   fontWeight: FontWeight.bold,
                                 ),)
                             ),
                           },
                           SizedBox(
                             height: 5,
                           ),


                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               if(data.price!="null")...
                               {
                                 Container(
                                     child: Text('' r"$"+data.price.toString(),style: TextStyle(
                                       color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR) ,
                                       fontFamily: "NotoSerif",
                                       fontSize: AppSizeClass.maxSize18,
                                       fontWeight: FontWeight.bold,

                                     ),)
                                 ),
                               },
                               // Container(
                               //   margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                               //   child: Padding(
                               //     padding: const EdgeInsets.all(8.0),
                               //     child: CustomButton(
                               //       onPressed: () async{
                               //          var id=data.id.toString();
                               //          var name=data.name.toString();
                               //         var imgae="";
                               //         if(data.image!=false)
                               //         {
                               //           imgae= data.image.toString();
                               //         }
                               //         else
                               //         {
                               //           imgae= "https://palrancho.co/wp-content/uploads/2020/03/Papa-Cocida.png";
                               //         }
                               //         Navigator.pushNamed(context, RouteNames.productdetails_screen,arguments: {
                               //           "product_id":id,
                               //           "product_name":name,
                               //           "product_image": imgae,
                               //
                               //           //"product_price": controller.futureCategoriews[index].price.toString()
                               //         });
                               //
                               //         databaseHelper!.insert(
                               //             CartModelClass(
                               //                 id: index,
                               //                 productId: data.id.toString(),
                               //                 productName: data.name,
                               //                 productDetails: data.name,
                               //                 initilPrice: double.parse(data.price.toString()),
                               //                 productPrice: double.parse(data.price.toString()),
                               //                 quantity: ValueNotifier(1),
                               //                 image: imgae
                               //             )
                               //         ).then((value)  {
                               //           print("add product added");
                               //           cart.addTotalPrice(double.parse(data.price.toString()));
                               //           cart.addCounter();
                               //
                               //         }).onError((error, stackTrace) {
                               //           print("erorr"+error.toString());
                               //         });
                               //
                               //       }, title: AppConstentData.addtocart,
                               //       colors:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                               //     ),
                               //   ),
                               // ),
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
      );
  }



}

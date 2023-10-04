import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/ManuController.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/AllCategories/AllCategoriesByIdDataModel.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';

import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class AllCategoriesPage extends StatefulWidget {
  var data;
   AllCategoriesPage({super.key,required this.data});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}
class _AllCategoriesPageState extends State<AllCategoriesPage> {
  MenuControllers controller=Get.put(MenuControllers());
  DatabaseHelper? databaseHelper=DatabaseHelper();
  List<AllCategoriesByIdDataModel> tempList = [];
  var cat_name="";
  var cat_id="";

  Widget _searchBar(){
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Categories Products Here...",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text){
          _filterDogList(text);
        },
      ),
    );
  }
  _filterDogList(String text) {
    if(text.isEmpty){
      setState(() {
        controller.catByIdList.value = tempList;
      });
    }
    else{
      final List<AllCategoriesByIdDataModel> filteredBreeds =[];
      tempList.map((breed){
        if(breed.name!.contains(text.toString().toUpperCase())){
          filteredBreeds.add(breed);
        }
      }).toList();
      setState(() {
        controller.catByIdList.value = filteredBreeds;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cat_name=widget.data['cat_name'];
    cat_id=widget.data['cat_id'];
    controller.dataCategoriesById(cat_id);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // You can set it back to the default color
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
    // ));
  }
  @override
      Widget build(BuildContext context) {
        return RefreshIndicator(
            displacement: 250,
            backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                title: Text(cat_name),
              ),
              body:  Obx(() => controller.loading.value?
              Center(child: CircularProgressIndicator(
                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : OrderData())
            ),
              onRefresh: () async {
                controller.dataCategoriesById(cat_id);
             }
           );
        }
        Widget OrderData(){
          return dataShow();
        }
        Widget dataShow(){
         final cart =Provider.of<CartProvider>(context);
          return Container(

            child: Obx(() => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:controller.catByIdList.length,
                itemBuilder: (context,cat_in){
                  var data=controller.catByIdList[cat_in];
                  return  Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Container(
                                child: GestureDetector(
                                onTap: () async{},
                                child: Container(
                                  child: Row(
                                    children: [
                                      if(data.images!=false)...
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
                                              width: 100,
                                              height: 100,
                                              child: Image.network(data.images!.last.src.toString(),fit: BoxFit.cover,),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),

                                        child: Text(""+data.name.toString(),style: TextStyle(
                                          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                          fontSize: AppSizeClass.maxSize14,
                                          fontWeight: FontWeight.bold,
                                        ),)
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),
                                            child: Text('' r"$"+data.price.toString(),style: TextStyle(
                                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                              fontFamily: "NotoSerif",
                                              fontSize: AppSizeClass.maxSize14,
                                              fontWeight: FontWeight.bold,
                                            ),)
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10,0,10,0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                                  ),
                                                  primary: GradientHelper.getColorFromHex(AppColors.RED_COLOR), // Background color
                                                ),
                                                onPressed: () async{
                                                  databaseHelper!.insert(
                                                      CartModelClass(
                                                        // id: cat_in,
                                                          productId: data.id.toString(),
                                                          productName: data.name,
                                                          productDetails: data.description,
                                                          initilPrice: double.parse(data.price.toString()),
                                                          productPrice: double.parse(data.price.toString()),
                                                          quantity: 1,
                                                          image: data.images!.last.src.toString()
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
                                                    Navigator.pushNamed(context, RouteNames.addtocart_screen);
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



                                                }, child: Text("add to cart")))
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                })),
          );
       }

}

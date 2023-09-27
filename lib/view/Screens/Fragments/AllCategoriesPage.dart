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
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/AllMenuAppBar.dart';
import 'package:provider/provider.dart';
class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  MenuControllers controller=Get.put(MenuControllers());
  DatabaseHelper? databaseHelper=DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.allCategories();
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
          body:  Obx(() => controller.loading.value?
          Center(child: CircularProgressIndicator(
            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : OrderData())



    ), onRefresh: () async {
      controller.allCategories();
    });
  }
  Widget OrderData(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //------------------custom app bar ----------------
          AllMenuAppBar(),
          showAllCategories(),
          dataShow(),
        ],
      ),
    );
  }

 Widget showAllCategories() {

    return  Obx(() => Container(
      height: 100,
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.catList!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async{
              controller.cat_id.value=controller.catByIdList[index].id.toString();
              controller.dataCategoriesById(controller.cat_id.value);
              },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Card(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.grey[300],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child:Center(
                        child: Text(controller.catList[index].name.toString(),
                          style: TextStyle(
                            fontSize: AppSizeClass.maxSize15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NotoSerif",
                            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
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
 Widget dataShow(){
   final cart =Provider.of<CartProvider>(context);
    return Container(
      height: 280,
      child: Obx(() => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:controller.catByIdList.length,
          itemBuilder: (context,cat_in){
            var data=controller.catByIdList[cat_in];
            return  Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: GestureDetector(
                onTap: () async{
                  var id=data.id;
                  var name=data.name.toString();
                  var imgae="";
                  if(data.images!.isNotEmpty)
                  {
                    imgae=data.images!.last.src.toString();
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
                                width: 160,
                                height: 160,
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
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),
                              width: 170,
                              child: Text(""+data.name.toString(),style: TextStyle(
                                color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                fontFamily: "NotoSerif",
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
                                    fontFamily: "NotoSerif",
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
                                        if(data.images!.isNotEmpty)
                                        {
                                          imgae= data.images!.last.src.toString();
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
                                                productDetails: data.description,
                                                initilPrice: double.parse(data.price.toString()),
                                                productPrice: double.parse(data.price.toString()),
                                                quantity: 1,
                                                image: imgae
                                            )
                                        ).then((value)  {
                                          print("add product added");
                                          cart.addTotalPrice(double.parse(data.price.toString()));
                                          cart.addCounter();

                                        }).onError((error, stackTrace) {
                                          print("erorr"+error.toString());
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
          })),
    );
 }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/ProductDetailsController.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/CartProductIncrementandDecrement.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:provider/provider.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ProductDetailsPage extends StatefulWidget {
  var data;
   ProductDetailsPage({this.data});
   @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var product_img="",product_id,product_name="";
  var product_desc="", product_quanity="";
  ProductDetailsController controller=Get.put(ProductDetailsController());
  DatabaseHelper? databaseHelper=DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product_id=widget.data['product_id'];
    product_img=widget.data['product_image'];
    product_name=widget.data['product_name'];
    controller.loadProduct();
    controller.recentProduct();
  }
  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = GradientHelper.getGradientFromStringColor(AppColors.Red_drak_COLOR,AppColors.RED_COLOR);
    controller.productId.value=product_id.toString();

    return Scaffold(

        bottomNavigationBar: Consumer<CartProvider>(
            builder: (context, value,  child) {
              final cart =Provider.of<CartProvider>(context);
              print("value.totalPrice"+value.totalPrice.toString());
              return Container(
                height: 100,
                child: Visibility(
                  visible: (controller.isLoading.isTrue?false:true),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0,20,0,0),
                          child: CustomButton(
                            onPressed: () async {
                              databaseHelper!.insert(
                                  CartModelClass(
                                    // id: cat_in,
                                      productId: product_id.toString(),
                                      productName: product_name,
                                      productDetails: controller.model.description,
                                      initilPrice: double.parse(controller.model.price.toString()),
                                      productPrice: double.parse(controller.model.price.toString()),
                                      quantity: 1,
                                      image: product_img
                                  )
                              ).then((value)  {
                                print("add product added");
                                cart.addTotalPrice(double.parse(controller.model.price.toString()));
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

                              },
                            title: AppConstentData.continues,
                            colors:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            isLoading: false.obs,),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

        body: Obx(() => controller.isLoading.value?  Center(child: CircularProgressIndicator(
        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : HomeData())
    );
  }
     Widget HomeData() {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            gradient: GradientHelper.getGradientFromStringColor(AppColors.Red_drak_COLOR,AppColors.RED_COLOR),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomApp(),
              CustomeImage(),
              CustomProductDetails(),
            ],
          ),
        ),
    );
  }
     Widget recentProducts(){
       final cart =Provider.of<CartProvider>(context);
         return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:controller.recentProduct.length,
        shrinkWrap: true,
        itemBuilder: (context,cat_in){
          var data=controller.recentProduct[cat_in];
          return  Container(

            child: GestureDetector(
              onTap: () async{},
              child: Container(
                child: Card(
                  elevation: AppSizeClass.maxSize10,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      if(data.imageUrl!=false)...
                      {
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0,2.0,5.0,5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR).withOpacity(0.3),
                                      offset: Offset(-1,10),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: CircleAvatar(
                                backgroundColor:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  child: CachedNetworkImage(imageUrl: data.imageUrl.toString(),
                                  )),
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
                            width: 100,
                            height: 100,
                            child: Image.network("https://palrancho.co/wp-content/uploads/2020/03/Papa-Cocida.png", fit: BoxFit.cover,),
                          ),
                        ),
                      },
                      SizedBox(
                        height: 10,
                      ),
                      if(data.postTitle!="null")...
                      {
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            width: 140,
                            height: 70,
                            child: Text(""+data.postTitle.toString(),style: TextStyle(
                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                              fontSize: AppSizeClass.maxSize13,
                              fontWeight: FontWeight.bold,
                               ),
                            )
                        ),
                      },
                      SizedBox(
                        height: 5,
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
                                      databaseHelper!.insert(
                                          CartModelClass(
                                            // id: cat_in,
                                              productId: data.iD.toString(),
                                              productName: data.postTitle.toString(),
                                              productDetails: "",
                                              initilPrice: double.parse(data.price.toString()),
                                              productPrice: double.parse(data.price.toString()),
                                              quantity: 1,
                                              image: product_img
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
                                          Navigator.pushNamed(context, RouteNames.addtocart_screen);

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

        });
     }
     Widget CustomeImage() {
        return Container(
          height: 250,
          child: Stack(
            children: [
              Column(
               children: [
                 Expanded(
                     flex: 1,
                     child: Container()),
                 Expanded(
                         flex: 1,
                      child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(50),
                               topRight: Radius.circular(50)
                           ),
                           color: AppColors.whiteColors

                       ),
                     )),
               ],
             ),
              Align(
                child:  Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR).withOpacity(0.3),
                            offset: Offset(-1,10),
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Card(
                    elevation: AppSizeClass.maxSize3,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: CircleAvatar(child: Image.network(product_img.toString(),fit: BoxFit.cover,)),
                  ),
                ),
              )
            ],
          ),
        );
     }
     Widget  CustomApp() {
        return Container(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                  Navigator.pop(context,"");
                }, icon:Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,

                )),
              ),
              SizedBox(height: 30,),
            ],
          ),
        );
    }
     Widget  CustomProductDetails() {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.whiteColors,

          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              //-----------------product name---------
              if(controller.model!=null || controller.model!="null")...
              {
               Padding(
                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                 child:  Text("" + controller.model!.name.toString(),
                   style: TextStyle(
                     color: GradientHelper.getColorFromHex(
                         AppColors.RED_COLOR),

                     fontSize: AppSizeClass.maxSize20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               )
              },

              //--------------------product description -----------------
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:   Text(""+CommonUtilsClass.removeHtmlTags(controller.model!.description.toString()),
              style: TextStyle(
                color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                fontSize: AppSizeClass.maxSize13,
                fontWeight: FontWeight.bold,
              ),
            ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 10),
                        child: Text('' r"$"+controller.model!.price.toString(),style: TextStyle(
                          color:GradientHelper.getColorFromHex(AppColors.RED_COLOR) ,

                          fontSize: AppSizeClass.maxSize18,
                          fontWeight: FontWeight.bold,

                        ),)
                    ),
                  ),
                  //----------------------- add to cart -----------
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //-------------recent product-----------------
              Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                 child: Text("Related Products",
                   style: TextStyle(
                     fontSize: AppSizeClass.maxSize20,
                     fontWeight: FontWeight.bold,

                     color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                 child: Text("View All",
                   style: TextStyle(
                     fontSize: AppSizeClass.maxSize13,
                     fontWeight: FontWeight.bold,

                     color:AppColors.green,
                   ),
                 ),
               ),
             ],
           ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child:  recentProducts(),
              )

            ],
          ),
        );
    }

}










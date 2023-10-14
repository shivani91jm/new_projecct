import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';

import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/CartProductIncrementandDecrement.dart';
import 'package:new_projecct/view/Widgets/CartProductTotalPrice.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});
  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}
class _AddToCartPageState extends State<AddToCartPage> {
  var totalTax=0.0;
  var gradtotal;
  var currentLocation="";
  var totalItem="";
  var useraddress="";
  @override
  void initState() {
    super.initState();
    totalTax=  totalTax* 0.07;
    context.read<CartProvider>().getData();
  }


  @override
  Widget build(BuildContext context) {
    DatabaseHelper? dbHelper = DatabaseHelper();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(4, 10, 30, 0),
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
              child: Icon(Icons.shopping_cart_checkout,
                color: AppColors.whiteColors,),
            ),
          )
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, value,  child) {
            gradtotal=(double.parse(value.totalPrice.toString())*7.00/100+double.parse(value.totalPrice.toString())).toStringAsFixed(2);
            print("value.totalPrice"+value.totalPrice.toString());
            return Container(
            height: 220,
              child: Visibility(
              visible: (((value.totalPrice.toString())=="0.00" ||(value.totalPrice.toString())=="0.0"||  (value.totalPrice.toString())=="-0.00" || (value.totalPrice.toString()).contains("-"))?false:true),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartProductTotalPrice(title: "Sub Total", value:   (value.totalPrice.toStringAsFixed(2))),
                    DividerWidgets(),
                    CartProductTotalPrice(title: "Tax (7%)", value: ((double.parse(value.totalPrice.toString())*7/100).toStringAsFixed(2))),
                    DividerWidgets(),
                    CartProductTotalPrice(title: "Total", value:   ((double.parse(value.totalPrice.toString())*7.00/100+double.parse(value.totalPrice.toString())).toStringAsFixed(2))),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(10,0,10,0),
                      child: CustomButton(
                        onPressed: () async {
                          {
                            Navigator.pushNamed(
                                context, RouteNames.checkout_screen,
                                arguments: {
                                  "page_flag": "1",
                                  "total_length": totalItem.toString(),
                                  "grand_price": gradtotal.toString(),
                                  "tax": (double.parse(
                                      value.totalPrice.toString()) * 7 / 100)
                                      .toStringAsFixed(2)
                                      .toString(),
                                  "subtotal": value.totalPrice.toStringAsFixed(
                                      2).toString(),
                                });
                          }
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


      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            FutureBuilder<List<CartModelClass>>(
             future: cart.getData(),
             builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data!.isEmpty)
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(ImageUrls.empty_url),
                          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            child: Text("Cart is Empty",
                            style: TextStyle(
                                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizeClass.maxSize25
                            ),),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    );
                  }
                else {
                  return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          totalItem=snapshot.data!.length.toString();
                          return Card(
                            elevation: AppSizeClass.maxSize10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 2.0, 5.0, 5.0),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR).withOpacity(0.3),
                                                  offset: Offset(-1, 10),
                                                  blurRadius: 10
                                              )
                                            ]
                                        ),
                                        child: Card(
                                          clipBehavior: Clip.hardEdge,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50.0),
                                          ),
                                          child: CircleAvatar(
                                              backgroundColor: GradientHelper
                                                  .getColorFromHex(
                                                  AppColors.RED_COLOR),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data![index]
                                                    .image.toString(),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //----------------------product name container  -----------
                                          Container(
                                            child: Text("" +
                                                snapshot.data![index]
                                                    .productName.toString(),
                                              style: TextStyle(
                                                color: GradientHelper
                                                    .getColorFromHex(
                                                    AppColors.RED_COLOR),

                                                fontSize: AppSizeClass
                                                    .maxSize15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          ),
                                          //---------------- product price------------------
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 10, 0, 0),
                                                    padding: EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    child: RichText(
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                          text: '' r"$",
                                                          style: TextStyle(
                                                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                                              fontSize: AppSizeClass.maxSize17),
                                                          children: [
                                                            TextSpan(text:
                                                                '${snapshot
                                                                    .data![index]
                                                                    .initilPrice!}\n',
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .bold,

                                                                  fontSize: AppSizeClass
                                                                      .maxSize17,

                                                                )),
                                                          ]),
                                                    ),
                                                  ),
                                                  if(snapshot.data![index].quantity > 1)...
                                                  {
                                                    Container(
                                                      margin: EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 0, 0),
                                                      padding: EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            text: 'Price' r"$",
                                                            style: TextStyle(
                                                                color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                                                fontSize: AppSizeClass
                                                                    .maxSize12),
                                                            children: [
                                                              TextSpan(
                                                                  text: '${snapshot.data![index].productPrice!}\n',
                                                                  style: const TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: AppSizeClass.maxSize12,

                                                                  )),
                                                            ]),
                                                      ),
                                                    ),
                                                  }
                                                ],
                                              ),
                                              Container(
                                                child: CartProductIncreAndDecre(
                                                  addQuantity: () {
                                                    int quantity = snapshot.data![index].quantity;
                                                    double? price = snapshot.data![index].initilPrice;
                                                    quantity++;
                                                    double? newprice = price! *
                                                        (quantity.toDouble());
                                                    dbHelper.updateQuantity(
                                                        CartModelClass(
                                                          // id:snapshot.data![index].id,
                                                            productId: snapshot.data![index].productId,
                                                            productName: snapshot.data![index].productName,
                                                            productDetails: snapshot.data![index].productDetails,
                                                            initilPrice: snapshot.data![index].initilPrice,
                                                            productPrice: newprice,
                                                            quantity: quantity,
                                                            image: snapshot.data![index].image)).
                                                    then((value) {
                                                      newprice = 0.0;
                                                      quantity = 0;
                                                      cart.addTotalPrice(
                                                          snapshot.data![index]
                                                              .initilPrice!);
                                                    }).onError((error,
                                                        stackTrace) {
                                                      print(error.toString());
                                                    });
                                                  },
                                                  deleteQuantity: () {
                                                    int quantity = snapshot
                                                        .data![index].quantity;
                                                    double? price = snapshot
                                                        .data![index]
                                                        .initilPrice;
                                                    quantity--;
                                                    double? newprice = price! *
                                                        (quantity.toDouble());
                                                    if (quantity > 0) {
                                                      dbHelper.updateQuantity(
                                                          CartModelClass(
                                                            // id:snapshot.data![index].id,
                                                              productId: snapshot.data![index].productId,
                                                              productName: snapshot.data![index].productName,
                                                              productDetails: snapshot.data![index].productDetails,
                                                              initilPrice: snapshot.data![index].initilPrice,
                                                              productPrice: newprice,
                                                              quantity: quantity,
                                                              image: snapshot.data![index].image)).
                                                      then((value) {
                                                        newprice = 0.0;
                                                        quantity = 0;
                                                        cart.removeTotalPrice(
                                                            snapshot.data![index].initilPrice!);
                                                      }).onError((error,
                                                          stackTrace) {
                                                        print(error.toString());
                                                      });
                                                    }
                                                  },

                                                  color: GradientHelper
                                                      .getColorFromHex(
                                                      AppColors.RED_COLOR),
                                                  text: snapshot.data![index].quantity!.toString(),
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 5, 5),
                                              ),

                                            ],
                                          ),
                                          GestureDetector(
                                               onTap:(){
                                                 dbHelper!.deleteCartItem(int.parse(snapshot.data![index].productId.toString()));
                                                 cart.removeCounter();
                                                 cart.removeTotalPrice(snapshot.data![index].productPrice!);
                                                 },
                                               child: Container(
                                                 child: Icon(
                                                    Icons.delete,
                                                    color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                                    size: 20,
                                                  ),
                                                 margin: EdgeInsets.fromLTRB(10, 0, 0, 0),


                                               ),
                                             )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      )
                  );
                }
              }
              return Center(child:  CircularProgressIndicator(
                color: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
              ));
            },
          )
          ],
      ),
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // context!.read<CartProvider>().dispose();
  }
  void getLocationValue()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      useraddress=prefs.getString('address_1')??"";

    });
  }
}

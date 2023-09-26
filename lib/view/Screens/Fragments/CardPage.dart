import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
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

  var totalTax;
  var gradtotal;

  @override
  void initState() {
    super.initState();
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
          double totalPrice=0.0;

          // for (var element in value.cart) {
          //   print("data"+element.productPrice.toString());
          //   print("quqnity"+element.quantity.toString());
          //   totalTax= ((element.productPrice! * double.parse(element.quantity!.toString())) + (totalPrice?? 0))*7.00/100;
          //   totalPrice = ((element.productPrice! * double.parse(element.quantity!.toString())) + (totalPrice ?? 0));
          //   gradtotal=totalTax+totalPrice;
          // }
          return Container(
            height: 250,
            color: Colors.grey[100],
            child: Column(
              children: [
                // ValueListenableBuilder<double?>(
                //     valueListenable: totalPrice,
                //     builder: (context, val, child) {
                //       return);
                //     }),
                CartProductTotalPrice(title: "Sub Total", value:   (value.totalPrice.toStringAsFixed(2))),
                DividerWidgets(),
              //  CartProductTotalPrice(title: "Tax", value:   (r'$'+((value.totalPrice.toStringAsFixed(2))))),
                ValueListenableBuilder<double?>(
                    valueListenable: ValueNotifier(totalTax),
                    builder: (context, val, child) {
                      return CartProductTotalPrice(
                          title: "Tax",
                          value:   (val?.toStringAsFixed(2) ?? '0'));
                    }),
                DividerWidgets(),
                ValueListenableBuilder<double?>(
                    valueListenable: ValueNotifier(gradtotal),
                    builder: (context, val, child) {
                      return CartProductTotalPrice(
                          title: "Total",
                          value:   (val?.toStringAsFixed(2) ?? '0'));
                    }),
                Padding(
                  padding:  EdgeInsets.fromLTRB(10,0,10,0),
                  child: CustomButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      var email=  await prefs.getString('email')?? "";
                      print("data"+email.toString());
                      if(email!="null" && email!="")
                        {
                          var product_id=cart.getData();
                          print("data"+product_id.toString());
                          Navigator.pushNamed(context, RouteNames.checkout_screen,arguments: {
                            "page_id":"1",
                          });

                        }
                      else {
                          var product_id=cart.getData();
                          print("data fgfhgfjhfgjghjhk"+product_id.toString());
                          showAlert();
                        }
                      },
                    title: AppConstentData.continues,
                      colors:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    isLoading: false.obs,),
                ),
              ],
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
              return  Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index)
                    {
                      return Card(
                        elevation: AppSizeClass.maxSize10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                                      child: CachedNetworkImage(imageUrl: snapshot.data![index].image.toString(),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(""+snapshot.data![index].productName.toString(),style: TextStyle(
                                        color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                        fontFamily: "NotoSerif",
                                        fontSize: AppSizeClass.maxSize14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      )),
                                  Container(
                                      child: Text(""+CommonUtilsClass.removeHtmlTags(snapshot.data![index].productDetails.toString()),
                                        style: TextStyle(
                                          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                          fontFamily: "NotoSerif",
                                          fontSize: AppSizeClass.maxSize14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Row(
                                    children: [
                                      // ValueListenableBuilder<int>(
                                      //     valueListenable: provider.cart[index].quantity!,
                                      //     builder: (context, val, child) {
                                      //       return ;
                                      //     }),
                                      CartProductIncreAndDecre(
                                        addQuantity: () {
                                          // cart.addQuantity(provider.cart[index].id!);
                                          // dbHelper!.updateQuantity(CartModelClass(
                                          //     id:provider.cart[index].id!,
                                          //     productId:  provider.cart[index].productId!.toString(),
                                          //     productName: provider.cart[index].productName,
                                          //     initilPrice: provider.cart[index].initilPrice,
                                          //     productPrice: provider.cart[index].productPrice,
                                          //     quantity: provider.cart[index].quantity!,
                                          //     image: provider.cart[index].image, productDetails: 'ghfhhfdg'))
                                          //     .then((value) {
                                          //   setState(() {
                                          //     cart.addTotalPrice(double.parse(provider.cart[index].productPrice.toString()));
                                          //   });
                                          // });
                                        },
                                        deleteQuantity: () {
                                          // cart.deleteQuantity(provider.cart[index].id!);
                                          // cart.removeTotalPrice(double.parse(provider.cart[index].productPrice.toString()));
                                        },

                                        color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
                                        text: snapshot.data![index].quantity!.toString(),
                                      ),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: '' r"$",
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${snapshot.data![index].productPrice!}\n',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "NotoSerif",
                                                    fontSize: AppSizeClass.maxSize14,

                                                  )),
                                            ]),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        dbHelper!.deleteCartItem(snapshot.data![index].id!);
                                       // cart.removeItem(provider.cart[index].id!);
                                        cart.removeCounter();
                                        cart.removeTotalPrice(snapshot.data![index].productPrice!);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade800,
                                      )
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
              );
            } else if (snapshot.hasError) {
              return Text('Cart Empty');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
        ],
      ),
      );

  }
  Future<void> showAlert() async {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login"),
            content: const Text("Please Login ...."),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.pushNamed(context, RouteNames.login_screen);
                  }, child: const Text("OK")),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: const Text("Cancel"))
                ],
              )
            ],
          );
        }
    );
  }
}

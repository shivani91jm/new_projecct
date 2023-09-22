import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
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
class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});
  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}
class _AddToCartPageState extends State<AddToCartPage> {
  DatabaseHelper? dbHelper = DatabaseHelper();
  var totalTax;
  var gradtotal;

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }
  @override
  Widget build(BuildContext context) {
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
        builder: (BuildContext context, value, Widget? child) {
          final ValueNotifier<double?> totalPrice = ValueNotifier(null);
          for (var element in value.cart) {
            print("data"+element.productPrice.toString());
            print("quqnity"+element.quantity.toString());
            print("total price"+totalPrice.value.toString());
           totalTax= ((element.productPrice! * double.parse(element.quantity!.value.toString())) + (totalPrice.value ?? 0))*7.00/100;
            totalPrice.value = ((element.productPrice! * double.parse(element.quantity!.value.toString())) + (totalPrice.value ?? 0));
            gradtotal=totalTax+totalPrice.value;
          }


          print("value"+totalTax.toString());
          return Container(
            height: 400,
            color: Colors.grey[100],
            child: Column(
              children: [
                ValueListenableBuilder<double?>(
                    valueListenable: totalPrice,
                    builder: (context, val, child) {
                      return CartProductTotalPrice(
                          title: "Sub Total",
                          value:   (val?.toStringAsFixed(2) ?? '0'));
                    }),
                DividerWidgets(),
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
                    onPressed: () async{
                      Navigator.pushNamed(context, RouteNames.checkout_screen,arguments: {
                        "page_id":"1",
                      });
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
          Expanded(
            child: Consumer<CartProvider>(
              builder:(BuildContext context, provider, widget){
                if(provider.cart.isEmpty)
                  {
                    return const Center(
                        child: Text(
                          'Cart is Empty',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ));
                  }
                  else
                  {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics:NeverScrollableScrollPhysics(),
                        itemCount:provider.cart.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index)
                         {
                            return Card(
                            elevation: AppSizeClass.maxSize10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
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
                                      child: Image.network(provider.cart[index].image!),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Container(
                                        child: Text(""+provider.cart[index].productName.toString(),style: TextStyle(
                                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                            fontFamily: "NotoSerif",
                                            fontSize: AppSizeClass.maxSize18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          )),
                                      Row(
                                        children: [
                                          ValueListenableBuilder<int>(
                                              valueListenable: provider.cart[index].quantity!,
                                              builder: (context, val, child) {
                                                return CartProductIncreAndDecre(
                                                  addQuantity: () {
                                                    cart.addQuantity(provider.cart[index].id!);
                                                    dbHelper!.updateQuantity(CartModelClass(
                                                        id:provider.cart[index].id!,
                                                        productId:  provider.cart[index].productId!.toString(),
                                                        productName: provider.cart[index].productName,
                                                        initilPrice: provider.cart[index].initilPrice,
                                                        productPrice: provider.cart[index].productPrice,
                                                        quantity: ValueNotifier(provider.cart[index].quantity!.value),
                                                        image: provider.cart[index].image, productDetails: 'ghfhhfdg'))
                                                        .then((value) {
                                                      setState(() {
                                                        cart.addTotalPrice(double.parse(provider.cart[index].productPrice.toString()));
                                                      });
                                                    });
                                                  },
                                                  deleteQuantity: () {
                                                    cart.deleteQuantity(
                                                        provider.cart[index].id!);
                                                    cart.removeTotalPrice(double.parse(
                                                        provider.cart[index].productPrice
                                                            .toString()));
                                                  },
                                                  text: val.toString(),
                                                  color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
                                                );
                                              }),
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
                                                      '${provider.cart[index].productPrice!}\n',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            dbHelper!.deleteCartItem(provider.cart[index].id!);
                                            provider.removeItem(provider.cart[index].id!);
                                            provider.removeCounter();
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
                    );
                  }
              },
            )

          ),
        ],
      ),
    );
  }

}

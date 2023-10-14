import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/CheckOutController.dart';
import 'package:new_projecct/database/db_helper.dart';
import 'package:new_projecct/model/ProductModel/ProductModelClass.dart';
import 'package:new_projecct/view/Widgets/CartProductIncrementandDecrement.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutPage extends StatefulWidget {
  var data;
   CheckOutPage({super.key,required this.data});
   @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}
enum SingingCharacter { Cash, online }
class _CheckOutPageState extends State<CheckOutPage> {
  String currentLocation="";
  var page_flag="1";
  var total_item="",grend_price="",tax="", subtotal="";
  var shoplocation="";
  CheckOutController controller =Get.put(CheckOutController());
  SingingCharacter? _character = SingingCharacter.Cash;
  DatabaseHelper? dbHelper = DatabaseHelper();
  var useraddress="",email="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      total_item= widget.data['total_length']??"";
      grend_price=widget.data['grand_price']??"";
      tax=widget.data['tax']??"";
      subtotal=widget.data['subtotal']??"";
    context.read<CartProvider>().getData();
    getLocationValue();
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      bottomNavigationBar: location(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                shadowColor: AppColors.green,
                elevation: 0,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,15,10,10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shop Location",
                                style: TextStyle(
                                  fontSize: AppSizeClass.maxSize20,
                                  fontWeight: FontWeight.bold,
                                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DividerWidgets(),
                              SizedBox(
                                height: 10,
                              ),
                              Text(""+shoplocation.toString(),
                                style: TextStyle(
                                  fontSize: AppSizeClass.maxSize17,
                                  fontWeight: FontWeight.normal,
                                  color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                ),
                              ),

                            ],
                          ),
                        ),
                        //--------------------- bill conatoner------------------
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,15,15,30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              GestureDetector(
                                onTap:(){
                                  Navigator.pushNamed(context, RouteNames.addtocart_screen);
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Bill Details", style: TextStyle(
                                        fontSize: AppSizeClass.maxSize20,
                                        fontWeight: FontWeight.bold,
                                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                      ),
                                    ),
                                    Text("Edit",
                                      style: TextStyle(
                                        fontSize: AppSizeClass.maxSize13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DividerWidgets(),
                              SizedBox(
                                height: 10,
                              ),
                              //---------------------total item ------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Item ",
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,

                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),

                                  Text(""+total_item,
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,

                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DividerWidgets(),
                              SizedBox(
                                height: 10,
                              ),
                              //----------------------sub total ------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total",
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,

                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),
                                  Text('' r"$"+subtotal.toString(),
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,
                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DividerWidgets(),
                              SizedBox(
                                height: 10,
                              ),
                              //----------------------tax --------------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax",
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,

                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),
                                  Text('' r"$"+tax.toString(),
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,
                                      color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DividerWidgets(),
                              SizedBox(
                                height: 10,
                              ),
                              //---------------total price----------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Price ",
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,

                                      color: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                                    ),
                                  ),
                                  Text('' r"$"+grend_price,
                                    style: TextStyle(
                                      fontSize: AppSizeClass.maxSize17,
                                      fontWeight: FontWeight.normal,
                                      color: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                                    ),
                                  ),
                                ],
                              ),
                              //------------------------edit data -----------
                              SizedBox(
                                height: 10,
                              ),

                              //---------------total price----------------


                            ],
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget location() {
    final cart = Provider.of<CartProvider>(context!);
    return Container(
      height: 180,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                 Expanded(child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5.0,10.0,10.0,10.0),
                       child: Icon(Icons.location_on,
                           size: AppSizeClass.maxSize30,
                           color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)),
                     ),
                     Expanded(
                       child: Container(
                         child: Text(useraddress,style: TextStyle(
                             color:AppColors.green,
                             fontWeight: FontWeight.bold,
                             fontSize: AppSizeClass.maxSize15
                         ),),
                       ),
                     )
                   ],
                 ),),
                    GestureDetector(
                      onTap: () async{
                        Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                          "page_flag":"2"
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,5.0,10.0,0.0),
                        child: Text("change",
                          style: TextStyle(
                            color:GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizeClass.maxSize15
                        ),
                        ),
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              DividerWidgets(),
              SizedBox(
                height: 20,
              ),
              if(page_flag=="1")...
                {
                   if(useraddress=="")...
                     {
                        CustomButton(
                           onPressed: () async {
                             Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                               "page_flag":"2"
                             });
                           },
                           title:'Select Address at next step',
                           colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                           isLoading: false.obs
                        )
                     }
                   else...
                     {
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Text("Payment Mode : ",
                                 style: TextStyle(
                                     color:GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                                     fontWeight: FontWeight.bold,
                                     fontSize: AppSizeClass.maxSize15
                                 ),
                               ),
                               Text("COD",
                                 style: TextStyle(
                                     color:AppColors.green,
                                     fontWeight: FontWeight.bold,
                                     fontSize: AppSizeClass.maxSize15
                                 ),),
                             ],
                           ),
                           Container(
                             width: 200,
                             child: Obx(() => CustomButton(
                                 onPressed: () async{

                                  if(email!="null" && email!="")
                                    {
                                      controller.checkoutOrder(cart);

                                    }
                                  else
                                    {
                                      showAlertLogin();
                                    }

                                 },
                                 title: controller.loading.value?"":'' r"$"+grend_price+" Place Order",
                                 colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                 isLoading: controller.loading
                             )),
                           )
                         ],
                       )
                     }

                }
                else...
                {
                   Row(
                     children: [
                      Row(
                        children: [
                          Text("Payment Mode",
                            style: TextStyle(
                                color:GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizeClass.maxSize15
                            ),),
                          Text("COD",
                            style: TextStyle(
                              color:AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizeClass.maxSize15
                          ),),
                        ],
                      ),
                        Obx(() =>  CustomButton(
                            onPressed: () async{

                              if(email!="null" && email!="")
                              {
                                CommonUtilsClass.toastMessage(email);
                                controller.checkoutOrder(cart);
                              }
                              else
                              {
                                  showAlertLogin();
                              }


                            }, title:controller.loading.value?"":'' r"$"+grend_price+" Place Order",
                            colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                            isLoading: controller.loading
                        ))
                     ],
                   )
                }
            ],
          ),
        ),
      ),
    );
 }
  void getLocationValue()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //  currentLocation=  prefs.getString('currentLocation')??"";
    setState(() {
      useraddress=prefs.getString('address_1')??"";
      email =  prefs.getString('email')??"";
    //  print("currentdata"+currentLocation.toString());

      shoplocation=prefs.getString("shop_name")??"";
    });
  }
  void PaymentDialogBox(){
     showDialog(
         context: context,
         builder: (BuildContext context) {
           return Dialog(
             shape: RoundedRectangleBorder(
                 borderRadius:
                 BorderRadius.circular(20.0)), //this right here
             child: Container(
               height: 200,
               child: Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Select Payment Mode",style: TextStyle(
                       fontSize: AppSizeClass.maxSize20,
                       fontWeight: FontWeight.bold,
                       fontFamily: "NotoSerif",
                       color:AppColors.greyColors,
                     )),
                     RadioListTile<SingingCharacter>(
                       title: const Text('Cash'),
                       value: SingingCharacter.Cash,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                     RadioListTile<SingingCharacter>(
                       title: const Text('Credit/Debit/Net Banking /Upi'),
                       value: SingingCharacter.online,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                   ],
                 ),
               ),
             ),
           );
         });
   }
   Future<void> showAlertLogin() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 3,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Align(alignment:Alignment.center,
            child: Row(
              children: [
                Container(
                  child:  Image.asset(ImageUrls.logo_url),
                  height: 40,
                  width: 30,
                ),
                Text('Please Login or SingUp',
                  style: TextStyle(
                    fontSize: AppSizeClass.maxSize17,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  ),
                ),
              ],
            )),
        content: Container(
            height: 80,
            decoration: BoxDecoration(),
            child: Column(
              children: [

                SizedBox(
                  height: 10,
                ),
                DividerWidgets(),
                SizedBox(
                  height: 10,
                ),
                Text("Don't have an account... ",
                  style: TextStyle(
                    fontSize: AppSizeClass.maxSize17,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),

                ),
              ],
            )),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                  style: TextStyle(
                    fontSize: AppSizeClass.maxSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteNames.login_screen);
                },
                child: Text('Yes',
                  style: TextStyle(
                    fontSize: AppSizeClass.maxSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
    Widget  listitem() {
  final cart = Provider.of<CartProvider>(context);
    return  FutureBuilder<List<CartModelClass>>(
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
                                              int quantity = snapshot
                                                  .data![index].quantity;
                                              double? price = snapshot
                                                  .data![index]
                                                  .initilPrice;
                                              quantity++;
                                              double? newprice = price! *
                                                  (quantity.toDouble());
                                              dbHelper!.updateQuantity(
                                                  CartModelClass(
                                                    // id:snapshot.data![index].id,
                                                      productId: snapshot
                                                          .data![index]
                                                          .productId,
                                                      productName: snapshot
                                                          .data![index]
                                                          .productName,
                                                      productDetails: snapshot
                                                          .data![index]
                                                          .productDetails,
                                                      initilPrice: snapshot
                                                          .data![index]
                                                          .initilPrice,
                                                      productPrice: newprice,
                                                      quantity: quantity,
                                                      image: snapshot
                                                          .data![index]
                                                          .image)).
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
                                                dbHelper!.updateQuantity(
                                                    CartModelClass(
                                                      // id:snapshot.data![index].id,
                                                        productId: snapshot
                                                            .data![index]
                                                            .productId,
                                                        productName: snapshot
                                                            .data![index]
                                                            .productName,
                                                        productDetails: snapshot
                                                            .data![index]
                                                            .productDetails,
                                                        initilPrice: snapshot
                                                            .data![index]
                                                            .initilPrice,
                                                        productPrice: newprice,
                                                        quantity: quantity,
                                                        image: snapshot
                                                            .data![index]
                                                            .image)).
                                                then((value) {
                                                  newprice = 0.0;
                                                  quantity = 0;
                                                  cart.removeTotalPrice(
                                                      snapshot
                                                          .data![index]
                                                          .initilPrice!);
                                                }).onError((error,
                                                    stackTrace) {
                                                  print(error.toString());
                                                });
                                              }
                                            },

                                            color: GradientHelper
                                                .getColorFromHex(
                                                AppColors.RED_COLOR),
                                            text: snapshot.data![index]
                                                .quantity!.toString(),
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
    );
  }
}

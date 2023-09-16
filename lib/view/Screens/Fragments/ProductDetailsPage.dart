import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:new_projecct/controller/ProductDetailsController.dart';
import 'package:new_projecct/view/Widgets/CartProductTotalPrice.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  var data;
   ProductDetailsPage({this.data});
   @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var product_img,product_id,product_name;
  ProductDetailsController controller=Get.put(ProductDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product_id=widget.data['product_id'];
    product_img=widget.data['product_image'];
    product_name=widget.data['product_name'];
  }
  @override
  Widget build(BuildContext context) {
    controller.productId.value=product_id.toString();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Consumer<CartProvider>(
          builder: (BuildContext context, value, Widget? child) {
            final ValueNotifier<double?> totalPrice = ValueNotifier(null);
            for (var element in value.cart) {
              print("data"+element.productPrice.toString());
              print("quqnity"+element.quantity.toString());
              print("total price"+totalPrice.value.toString());
              totalPrice.value = ((element.productPrice! * double.parse(element.quantity!.value.toString())) + (totalPrice.value ?? 0));
            }
            return Container(
              height: 140,
              child: Column(
                children: [
                  ValueListenableBuilder<double?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return CartProductTotalPrice(
                            title: AppConstentData.totalPrice,
                            value:   (val?.toStringAsFixed(2) ?? '0'));
                      }),
                  // Padding(
                  //   padding:  EdgeInsets.fromLTRB(10,0,10,0),
                  //   child: CustomButton(onPressed: (){
                  //   }, title: AppConstentData.addtocart,
                  //       colors:GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR)),
                  // ),
                ],
              ),
            );
          }),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
                Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(40)),
                        color: Colors.orange),
                    child: Image.network(product_img,),
                  ),
                ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     ValueListenableBuilder<int>(
                    //         valueListenable: ValueNotifier(1),
                    //         builder: (context, val, child) {
                    //           return CartProductIncreAndDecre(
                    //             addQuantity: () {}, deleteQuantity: () {  }, text: '1',
                    //             color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),);
                    //             },
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    //---------------------product name------------------
                    if(controller.model!=null || controller.model!="null")...
                      {
                        if(controller.model!.name != "null" ||
                            controller.model!.name != "null")...
                        {
                          Text("" + controller.model!.name.toString(),
                            style: TextStyle(
                              color: GradientHelper.getColorFromHex(
                                  AppColors.RED_COLOR),
                              fontFamily: "NotoSerif",
                              fontSize: AppSizeClass.maxSize20,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                        },
                      },
                    //--------------------product description -----------------
                    Text(""+CommonUtilsClass.removeHtmlTags(controller.model!.description.toString()),
                      style: TextStyle(
                        color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        fontFamily: "NotoSerif",
                        fontSize: AppSizeClass.maxSize16,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //-------------------------- recent product ----------------------
              Column(
                children: [
                  Container(
                    child: Text("Related Products",
                      style: TextStyle(
                        fontSize: AppSizeClass.maxSize20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NotoSerif",
                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      ),
                    ),
                  ),
                 SizedBox(
                   height: 20,
                 ),
                 Container(
                   height: 400,
                   width: MediaQuery.of(context).size.width,
                   child:  recentProducts(),
                 )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget recentProducts(){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:controller.recentProduct.length,
        shrinkWrap: true,
        itemBuilder: (context,cat_in){
          var data=controller.recentProduct[cat_in];
          return  Container(
            height: MediaQuery.of(context).size.height*0.5,
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
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: 180,
                              height: 180,
                              child: Image.network(data.imageUrl.toString(),fit: BoxFit.cover,),
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
                      if(data.postTitle!="null")...
                      {
                        Container(
                            width: 180,
                            height:80,
                            child: Text(""+data.postTitle.toString(),style: TextStyle(
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
                          //       onPressed: () async{},
                          //       title: AppConstentData.addtocart,
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

        });
  }

}










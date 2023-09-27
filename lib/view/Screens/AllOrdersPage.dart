import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/AllOrdersControllers.dart';
import 'package:provider/provider.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});
  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  AllOrdersController controller=Get.put(AllOrdersController());

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
          title: Text("Your Orders"),
        ),
        body: Obx(() => controller.isLoading.value?
        Center(child: CircularProgressIndicator(
          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : OrderData())),
        onRefresh: () async{
      controller.loadData();
    });
  }
   Widget OrderData(){

    return  Obx(() =>  ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:controller.datass.length,
        itemBuilder: (context,cat_in){
          var data=controller.datass[cat_in];
          return  Container(
            child: GestureDetector(
              onTap: () async{},
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  child: CircleAvatar(
                                    child: CachedNetworkImage(
                                      imageUrl: data.lineItems!.last.image.toString(),
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(""+data.dateCreated.toString(),
                                        style: TextStyle(
                                            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizeClass.maxSize15
                                        ),),
                                      Text(data.lineItems!.last.name.toString(),
                                        style: TextStyle(
                                            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizeClass.maxSize13
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("status:",
                                            style: TextStyle(
                                                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSizeClass.maxSize13
                                            ),),
                                          Text(""+data.status.toString(),
                                            style: TextStyle(
                                                color: AppColors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSizeClass.maxSize13
                                            ),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('' r"$"+data.total.toString(),
                                    style: TextStyle(
                                        color: AppColors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizeClass.maxSize15
                                    ),
                                  ),
                                  Align(
                                    child: IconButton(onPressed: ()async {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.green,
                                        size: AppSizeClass.maxSize17,
                                      ),

                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        //---------------------step progress bar ---------------------
                        Container(
                          padding: EdgeInsets.fromLTRB(20,0,0,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height:20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    child: Icon(Icons.add,
                                      color: AppColors.whiteColors,
                                      size: 12,
                                    ),
                                  ),
                                  Expanded(child:  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,2,0,0),
                                    child: Text("5637 Coral Ridge Drive Coral Springs, FL 33076",
                                      style: TextStyle(
                                          color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                          fontWeight: FontWeight.normal,
                                          fontSize: AppSizeClass.maxSize13
                                      ),
                                    ),

                                  ))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(3,0,0,0),
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height:20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.remove,
                                        color: AppColors.whiteColors,
                                        size: 12,),
                                    ),
                                  ),
                                  Expanded(child:  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,2,0,0),
                                    child: Text(data.shipping!.address1.toString(),
                                      style: TextStyle(
                                          color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                          fontWeight: FontWeight.normal,
                                          fontSize: AppSizeClass.maxSize13
                                      ),
                                    ),

                                  ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        }));
   }
}

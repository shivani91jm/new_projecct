import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/AllOrdersControllers.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});
  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  AllOrdersController controller=Get.put(AllOrdersController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadData();
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
          title: Text("Your Orders"),
        ),
        body: Container(
          child: Obx(() => controller.isLoading.value?
          Center(child: CircularProgressIndicator(
            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : OrderData()),
        )),
        onRefresh: () async{
         controller.loadData();
      });
  }
   Widget OrderData() {
    return  Obx(() => controller.datanotfound.value?Center(child: Text("No data found... ",
      style: TextStyle(
          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          fontWeight: FontWeight.bold,
          fontSize: AppSizeClass.maxSize20
      ),
    )):
    Obx(() =>  ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:controller.datass.length,
        itemBuilder: (context,cat_in){
          var data=controller.datass[cat_in];
          DateTime originalDate = DateTime.parse(data.dateCreated.toString());
          String desiredFormat = "dd-MM-yyyy HH:mm:ss";
          DateFormat formatter = DateFormat(desiredFormat);
          String formattedDate = formatter.format(originalDate);
          return  Container(
            child: GestureDetector(
              onTap: () async{},
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 100,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white.withOpacity(0.6),
                              ),
                              child: CircleAvatar(
                                child: CachedNetworkImage(
                                  imageUrl: data.lineItems!.last.image!.src.toString(),
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.whiteColors,),
                                ),
                                backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(""+formattedDate.toString(),
                                    style: TextStyle(
                                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizeClass.maxSize17
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                      child: Text(data.lineItems!.last.name.toString(),
                                        style: TextStyle(
                                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizeClass.maxSize12
                                        ),
                                      ),
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
                                  ),
                                  //----------------sub total -------
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("Sub Total:",
                                          style: TextStyle(
                                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizeClass.maxSize13
                                          ),),
                                        Text(' ' r"$"+data.lineItems!.last.subtotal.toString(),
                                          style: TextStyle(
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizeClass.maxSize13
                                          ),),
                                      ],
                                    ),
                                  ),
                                  //-------------------tax-----------
                                  if(data.lineItems!.last.totalTax.toString()!="0.00")...
                                  {
                                    Container(
                                      child: Row(
                                        children: [
                                          Text("Tax:",
                                            style: TextStyle(
                                                color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSizeClass.maxSize13
                                            ),),
                                          Text(' ' r"$"+data.lineItems!.last.totalTax.toString(),
                                            style: TextStyle(
                                                color: AppColors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSizeClass.maxSize13
                                            ),),
                                        ],
                                      ),
                                    ),
                                  },
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("Total:",
                                          style: TextStyle(
                                              color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizeClass.maxSize12
                                          ),),
                                        Text(' ' r"$"+data.total.toString(),
                                          style: TextStyle(
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizeClass.maxSize13
                                          ),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        })));
   }


}

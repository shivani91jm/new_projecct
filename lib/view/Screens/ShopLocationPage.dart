import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CheckInternetController.dart';
import 'package:new_projecct/controller/LocationController.dart';
import 'package:new_projecct/model/LocationModel/LocationModelClass.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopLocationPage extends StatefulWidget {
  const ShopLocationPage({super.key});
  @override
  State<ShopLocationPage> createState() => _ShopLocationPageState();
}
class _ShopLocationPageState extends State<ShopLocationPage> {
  final CheckInternetController _controller = Get.find<CheckInternetController>();
  LocationController controller =Get.put(LocationController());
  var shop_value="";
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,20),
        child: SingleChildScrollView(
          child: Container(
            height: 50,
            child: CustomButton(
              onPressed: () async {
              if(controller.selectedLocationId!.value.storeUrl.toString()!="" && controller.selectedLocationId!.value.storeUrl.toString()!="null")
                {
                  Navigator.pushNamed(context!,RouteNames.dashboard_screen);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var shopUrl=   prefs.getString('shopUrl')?? "";
                }
                 else
                  {
                    Get.snackbar(
                        "Please Select any shop location",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                        borderRadius: 5,
                        margin: EdgeInsets.all(5),
                        colorText: Colors.white,
                        duration: Duration(seconds: 2),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                  }

              // print("shop url"+shopUrl.toString()+"shop consumer key"+shopConsumerKey.toString()+"shop consumer secrete"+ShopConsumerScreate.toString());
            }, title: AppConstentData.continues,
              colors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), isLoading: false.obs,
            ),
          ),
        ),
      ),
      body: Obx(() => _controller.connectionType.value == 1 ? datawiget() : _controller.connectionType.value == 2 ?  datawiget() : NoInternetClass(page: RouteNames.location_screen,)),
    ),
        onRefresh: () async{
          controller.fetchLocationData();
        });
  }
  Widget homeLocationData(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(AppConstentData.chooseShopLocation,
                style: TextStyle(
                    color: AppColors.blackColors,
                    fontSize: AppSizeClass.maxSize20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif"
                ),),
            ),
          ),
          SizedBox(
            height:10,
          ),
          locationWidget(),
        ],
      ),
    );
  }

  Widget locationWidget() {
    return Obx(() => ListView.builder(
      itemCount: controller.locationList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR) ,
              ),
            ),
            child: Obx(() => RadioListTile(
              activeColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
              autofocus: true,
              hoverColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.locationList[index].storeName.toString(),
                  style: TextStyle(
                    color:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizeClass.maxSize15,
                  ),),
              ),
              value: controller.locationList[index],
              groupValue: controller.selectedLocationId!.value,
              onChanged: (value) async {
                print("value of shop"+value.toString());
                controller.selectedLocationId!.value= value as Locations;
                print("controller"+controller.selectedLocationId!.value.storeUrl.toString());
                var shopUrl=controller.selectedLocationId!.value.storeUrl.toString();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var consumer_key=controller.selectedLocationId!.value.consumerKey.toString();
                    var consumer_secrete=controller.selectedLocationId!.value.consumerSecret.toString();
                    var shop_name=controller.selectedLocationId!.value.storeName.toString();
                      prefs.setString('shopUrl', shopUrl);
                      prefs.setString("shop_consumer_key", consumer_key);
                      prefs.setString("shop_consumer_secrete", consumer_secrete);
                      prefs.setString("shop_name", shop_name);
                    print("choose location"+shopUrl +"shop id"+shop_name+"key"+consumer_key+"secrete"+consumer_secrete);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              ),
            ),
          ),
        );
      },
    ));
 }

  Widget  datawiget() {
      return  Obx(() =>  controller.loading.value? Center(child: CircularProgressIndicator(color:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),),) : homeLocationData(

      ));
  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/CompleteAddressPage.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
class SetDeliveryLocation extends StatelessWidget {
  DeliveryLocationController controller;
  BuildContext? contexts;
 final String currentLocaion;
 final String page_flag;
 SetDeliveryLocation({Key? key, required this.controller,required this.contexts,required this.currentLocaion,required this.page_flag});
   @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*2,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: AppSizeClass.maxSize5,
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
             Container(
               width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Icon(Icons.location_on,
                     size: AppSizeClass.maxSize30,
                     color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),),
                 Container(
                   width: MediaQuery.of(context).size.width*0.8,
                   child:   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(currentLocaion,
                       style: TextStyle(
                           color: AppColors.blackColors,
                           fontSize: AppSizeClass.maxSize16,
                           fontWeight: FontWeight.bold,
                           fontFamily: "NotoSerif"
                       ),),
                   ),
                 )
                 ],
               ),
             ),
              SizedBox(
                height: 20,
              ),
             GestureDetector(
               onTap: () async{
                 Navigator.pushNamed(context, RouteNames.address_form_screen);
               },
               child:  Container(
                 width: MediaQuery.of(context).size.width*0.8,
                 child:   Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Select or Enter Manual Location",
                     style: TextStyle(
                         color: AppColors.blackColors,
                         fontSize: AppSizeClass.maxSize16,
                         fontWeight: FontWeight.bold,
                         fontFamily: "NotoSerif"
                     ),),
                 ),
               ),
             ),
              CustomButton(
                onPressed: () async
                {
                 // Navigator.pop(context,"");
               //   controller.selectLocation(currentLocaion);
                },

                title: AppConstentData.confirmLocation,
                colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR), isLoading: false.obs,
              )
            ],
          ),
        ),
      ),
    );
  }
  // void _showBottomSheet(BuildContext context,DeliveryLocationController controller) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CompleteAddressPage(controller: controller,);
  //     },
  //   );
  // }
}

import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class HomeAppBar extends StatelessWidget {
  var currentLocation;
   HomeAppBar({super.key,required this.currentLocation});
   @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         GestureDetector(
           onTap: () async {
             Navigator.pushNamed(context, RouteNames.complete_address_screen);
           },
           child: Container(
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.fromLTRB(8.0,15.0,0.0,0.0),
                   child: Icon(Icons.location_on,
                     size: AppSizeClass.maxSize30,
                     color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(8.0,10.0,0.0,0.0),
                     child: Text(currentLocation,style: TextStyle(
                         color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                         fontWeight: FontWeight.bold,
                         fontSize: AppSizeClass.maxSize17
                     ),),
                   ),
                 )
               ],
             ),
           ),
         )
        ],
      ),
    );
  }
}

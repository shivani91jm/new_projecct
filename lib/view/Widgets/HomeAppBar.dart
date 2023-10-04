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
      width: MediaQuery.of(context).size.width*.8,
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
                   padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                   child: Icon(Icons.location_on,
                     size: AppSizeClass.maxSize30,
                     color: AppColors.whiteColors),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                     child: Text(currentLocation,
                       style: TextStyle(
                         color:AppColors.whiteColors,
                         fontWeight: FontWeight.bold,
                         fontSize: AppSizeClass.maxSize14
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

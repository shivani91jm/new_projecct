import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         GestureDetector(
           onTap: () async {
             Navigator.pushNamed(context, RouteNames.delivery_screen);
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
                 Padding(
                   padding: const EdgeInsets.fromLTRB(8.0,8.0,0.0,0.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Row(
                        children: [
                          Text("O Block",style: TextStyle(
                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizeClass.maxSize17
                          ),),
                          Icon(Icons.arrow_drop_down_rounded,
                            size: AppSizeClass.maxSize30,
                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                          )
                        ],
                      ),
                       Text("Kiwadi Nagar",style: TextStyle(
                           color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                           fontWeight: FontWeight.bold,
                           fontSize: AppSizeClass.maxSize14
                       ),),
                     ],
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

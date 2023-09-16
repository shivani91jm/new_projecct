import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';

class AppDetailsPage extends StatelessWidget {
  const AppDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email,color: AppColors.whiteColors,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("palranchorestaurant@gmail.com",style: TextStyle(
                        color: AppColors.whiteColors,
                        fontFamily: "NotoSerif",
                        fontSize: AppSizeClass.maxSize16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.phone_in_talk_rounded,color: AppColors.whiteColors,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("+ 954-340-4611",style: TextStyle(
                        color: AppColors.whiteColors,
                        fontFamily: "NotoSerif",
                        fontSize: AppSizeClass.maxSize16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),

        ],
      )),
    );
  }
}

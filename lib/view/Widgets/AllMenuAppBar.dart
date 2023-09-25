import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Widgets/BezierClipper.dart';
class AllMenuAppBar extends StatelessWidget {
  const AllMenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),

      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(0.4),
              image: new DecorationImage(
                  image: new ExactAssetImage(ImageUrls.contact_url),
                  fit: BoxFit.cover,
              ),// Color of the curved bottom area
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(height: 30),
              Visibility(
                  visible: false,
                  child:   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: (){
                  Navigator.pop(context,"");
                  }, icon:Icon(
                  Icons.arrow_back_ios_new,
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),

                  )),
                  ),
                  ),
              SizedBox(height: 30,),
              //--------------------------search box -----------------------
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.4),
                ),
                child: Column(
                  children: [],
                ),
              )
            ],
            )
          ),

        ]
      ),
    );
  }
}

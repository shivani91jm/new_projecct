import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Widgets/BezierClipper.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final double height;
  final bool flag;
  const CustomAppBar({Key? key,
    required this.text,
    required this.height,
    required this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      child: ClipPath(
        clipper: BezierClipper(),
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage(ImageUrls.contact_url),
              fit: BoxFit.cover
            ),// Color of the curved bottom area
          ),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Visibility(
                visible: flag,
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
              Align(
                alignment: Alignment.center,
                child: Text(text,style: TextStyle(
                  color: AppColors.whiteColors,
                  fontFamily: "NotoSerif",
                  fontSize: AppSizeClass.maxSize30,
                  fontWeight: FontWeight.bold
                ),),
              ),

            ],
          )
          ),
        ),
      ),
    );
  }
}

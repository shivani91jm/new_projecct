import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, okBtn,cancelBtn;
  final Image img;
  
  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.okBtn,required this.cancelBtn, required this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeClass.padding),
      ),
      elevation: 4,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: AppSizeClass.padding,top: AppSizeClass.avatarRadius
              + AppSizeClass.padding, right: AppSizeClass.padding,bottom: AppSizeClass.padding
          ),
          margin: EdgeInsets.only(top: AppSizeClass.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizeClass.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: GradientHelper.getColorFromHex(AppColors.RED_COLOR)),),
              SizedBox(height: 10,),
              Text(widget.descriptions,style: TextStyle(fontSize: 16,color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                          backgroundColor: AppColors.whiteColors// Background color
                        ),
                        onPressed: () {
                          Navigator.pop(context,"");
                          Navigator.pushReplacementNamed(context, RouteNames.dashboard_screen);

                         },
                          child: Text(widget.okBtn,
                            style: TextStyle(fontSize: 18,color: AppColors.green,
                            fontWeight: FontWeight.bold)),

                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.whiteColors// Background color
                        ),
                        onPressed: () async {
                            Navigator.pop(context,"");
                          },
                          child: Text(widget.cancelBtn,style:
                          TextStyle(fontSize: 18,
                             fontWeight: FontWeight.bold,
                              color:   GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: AppSizeClass.padding,
          right: AppSizeClass.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: AppSizeClass.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppSizeClass.avatarRadius)),
                child: Image.asset(ImageUrls.check_url)
            ),
          ),
        ),
      ],
    );
  }
}

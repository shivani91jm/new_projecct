import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text, required this.img}) : super(key: key);

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
      elevation: 0,
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
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context!,RouteNames.location_screen);
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),

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

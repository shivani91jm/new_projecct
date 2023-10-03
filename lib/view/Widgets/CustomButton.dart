import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  Color? colors;
  String? title;
 final  RxBool isLoading;
 CustomButton({Key?key,required this.onPressed,required this.title,required this.colors,required this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: colors,
      splashColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
          child: isLoading.value? Container(
            height: 15,
            width: 15,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColors,
              ),
            ),
          ) : Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.whiteColors,
                  fontSize: AppSizeClass.maxSize15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif"
              ),
            ),
          ),
        ),
      ),
      onPressed: isLoading .value? null : onPressed,
      shape: const StadiumBorder(),
    );
  }
}
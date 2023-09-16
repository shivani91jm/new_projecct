import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  Color? colors;
  String? title;
 final  bool isLoading;

  CustomButton({Key?key,required this.onPressed,required this.title,required this.colors,required this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: colors,
      splashColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children:  <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,2.0),
                child: isLoading? Container(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colors,
                    ),
                  ),
                ) : Text(title!,
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
          ],
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      shape: const StadiumBorder(),
    );
  }
}
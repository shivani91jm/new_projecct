import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';

class DialogUtils{
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;
  static void showCustomDialog(BuildContext context,
      {  required String title,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        String content="Are You sure Logout these application",
        required  okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(
              children: [
                Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizeClass.maxSize20,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.RED_COLOR)



                ),),
                SizedBox(height: 15,),
                DividerWidgets(),
              ],
            ),
            content: Text(content,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppSizeClass.maxSize15,
                fontFamily: "NotoSerif",
                color: AppColors.blackColors

              ),),
            actions: <Widget>[
              Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     TextButton(
                       style: TextButton.styleFrom(
                         primary: Colors.teal,),
                       child: Text(okBtnText,
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: AppSizeClass.maxSize17,
                             fontFamily: "NotoSerif",
                             color: GradientHelper.getColorFromHex(AppColors.RED_COLOR)

                         ),),
                       onPressed: okBtnFunction(),
                     ),
                     TextButton(
                         style: TextButton.styleFrom(
                           primary: Colors.teal,),
                         child: Text(cancelBtnText,
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: AppSizeClass.maxSize17,
                               fontFamily: "NotoSerif",
                               color: AppColors.green
                           ),),
                         onPressed: () => Navigator.pop(context))
                   ],
                 )
            ],
          );
        });
  }
}
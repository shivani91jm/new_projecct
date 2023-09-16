import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
class CartProductTotalPrice extends StatelessWidget {
  final String title, value;
  const CartProductTotalPrice({Key? key, required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(

   margin: EdgeInsets.all(10),

      child:   Padding(
        padding:  EdgeInsets.fromLTRB(10,10,10,8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                color: AppColors.blackColors,
                fontSize: AppSizeClass.maxSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('' r"$"+ value.toString(),
             style: TextStyle(
              color: AppColors.blackColors,
              fontSize: AppSizeClass.maxSize20,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

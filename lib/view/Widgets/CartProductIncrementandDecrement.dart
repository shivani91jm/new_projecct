import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class CartProductIncreAndDecre extends StatelessWidget {
  final VoidCallback addQuantity;
  final String text;
  final VoidCallback deleteQuantity;
  final Color? color;

  const CartProductIncreAndDecre({Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text,
        required this.color
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      // decoration:  BoxDecoration(
      //   color: color,
      //   // borderRadius: BorderRadius.circular(15),
      //   // border: Border.all(
      //   //   color: color !,
      //   // ),
      // ),
      child: Row(
        children: [
              Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration:  BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: color !,
                  ),
                ),
                  child: Align(
                    alignment: Alignment.topLeft,
                      child: IconButton(onPressed: deleteQuantity,
                          icon:  Icon(Icons.remove,color:AppColors.whiteColors,
                            size: 20,))
                  )),
              Text(text,style: TextStyle(
                  color: color!,
                  fontFamily: "",
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizeClass.maxSize16
              ),),
              Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration:  BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: color !,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed: addQuantity,
                        icon: Align(
                          alignment: Alignment.center,
                            child: const Icon(Icons.add,color: AppColors.whiteColors, size: 20))),
                  )),
            ],
      ),
    );
  }
}

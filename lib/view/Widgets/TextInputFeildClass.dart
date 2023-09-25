import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
class TextInputFields extends StatelessWidget {
 final TextEditingController controller;
 final bool isHint;
 final String hintText;
final String labelText;
 final TextInputType nmber;
 final String? Function(String?) validator;
 Color? bordercolors;
 Color? textcolors;

 TextInputFields({Key?key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.isHint,
    required this.nmber,
    required this.validator,
   required  this.bordercolors,
   required this.textcolors
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //------------icon----------------

    return TextFormField(
      controller: controller,
      obscureText: isHint,
      keyboardType: nmber,
      validator: validator,
      style: TextStyle(
        fontSize: 16.0,
        color: textcolors, // Change the text color here
      ),
      cursorColor: textcolors,
      decoration: InputDecoration(
        filled: false,

        contentPadding: EdgeInsets.only(left: 11, right: 3, top: 12, bottom: 12),
      //  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: textcolors,
            fontFamily: "NotoSerif",
            fontWeight: FontWeight.w500
        ),
        errorStyle: TextStyle(
          color: bordercolors
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: bordercolors!)
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color:textcolors,
          fontFamily: "NotoSerif",
            fontWeight: FontWeight.w500
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide:  BorderSide(
            color: bordercolors!
          )
        ),

        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizeClass.maxSize10),
            borderSide:  BorderSide(
                color: bordercolors!
            )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide:  BorderSide(
                color: bordercolors!
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: bordercolors!)
        ),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CompleteAddressPage extends StatelessWidget {
  DeliveryLocationController controller;
  CompleteAddressPage({Key? key,required this.controller});
  TextEditingController flatController=TextEditingController();
  TextEditingController areaController=TextEditingController();
  TextEditingController nerarByController=TextEditingController();
  TextEditingController houseNoController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(AppConstentData.entercompleteadd,
                      style: TextStyle(
                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                        fontSize: AppSizeClass.maxSize20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NotoSerif"
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(AppConstentData.orderingfor,style: TextStyle(
                      color: AppColors.blackColors,
                      fontSize: AppSizeClass.maxSize14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "NotoSerif"
                  ),),
                  Obx(() =>  RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.fromLTRB(3,0,2,2),
                    activeColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    hoverColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    title: Text('Myself',style: TextStyle(
                        color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        fontSize: AppSizeClass.maxSize14,
                        fontWeight: FontWeight.w300,
                        fontFamily: "NotoSerif"
                    ),),
                    value: 'YES',
                    groupValue: controller.selectedValue.value,
                    onChanged: (value) {
                      controller.updateSelectedValue(value!);
                    },
                  ),
                  ),
                  Obx(() =>   RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.fromLTRB(3,0,2,2),
                    activeColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    hoverColor: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                    title: Text("Someone else",style: TextStyle(
                        color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        fontSize: AppSizeClass.maxSize14,
                        fontWeight: FontWeight.w300,
                        fontFamily: "NotoSerif"
                    ),),
                    value: 'NO',
                    groupValue: controller.selectedValue.value,
                    onChanged: (value) {
                      controller.updateSelectedValue(value!);
                    },
                  ),),
                  Text(AppConstentData.saveasaddress,style: TextStyle(
                      color: AppColors.blackColors,
                      fontSize: AppSizeClass.maxSize14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "NotoSerif"
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                    enable: true,
                    controller:houseNoController,
                    hintText: AppConstentData.flathouseno,
                    labelText:  AppConstentData.flathouseno, isHint: false,
                    nmber: TextInputType.text,
                    validator: (value){
                      if (value!.isEmpty) {
                        return CommonUtilsClass.toastMessage("" + AppConstentData.flathouseno);
                      }
                      else {
                        return null;
                      }
                    },
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                    enable: true,
                    controller: areaController,
                    hintText: AppConstentData.areasectorlocatity,
                    labelText:  AppConstentData.areasectorlocatity, isHint: false,
                    nmber: TextInputType.text,
                    validator: (value){
                      if (value!.isEmpty) {
                        return CommonUtilsClass.toastMessage("" + AppConstentData.areasectorlocatity);
                      }
                      else {
                        return null;
                      }
                    },
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                    enable: true,
                    controller: nerarByController,
                    hintText: AppConstentData.nearby,
                    labelText:  AppConstentData.nearby, isHint: false,
                    nmber: TextInputType.text,
                    validator: (value){
                      return null;
                    },
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(onPressed: () async{
                    // if(formKey.currentState!.validate())
                    // {
                      var flatno=flatController.text;
                      var area=areaController.text;
                      var nearby=nerarByController.text;
                      var houseno=houseNoController.text;
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('type',controller.typeAreaLikeHome.value);
                      prefs.setString("flat", flatno);
                      prefs.setString("area", area);
                      prefs.setString("houseno", houseno);
                      prefs.setString("nearby", nearby);
                    //}
                  },
                    title: AppConstentData.saveadd,
                      colors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), isLoading: false.obs,),
                  // Add more list items here
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

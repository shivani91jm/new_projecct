import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
class CompleteAddressPage extends StatelessWidget {
  DeliveryLocationController controller;
  CompleteAddressPage({Key? key,required this.controller});
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
                  ),),
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
                    controller: controller.houseNoController,
                    hintText: AppConstentData.flathouseno,
                    labelText:  AppConstentData.flathouseno, isHint: false,
                    nmber: TextInputType.text,
                    validator: controller.validateFlatOrHouseNo,
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                    controller: controller.areaController,
                    hintText: AppConstentData.areasectorlocatity,
                    labelText:  AppConstentData.areasectorlocatity, isHint: false,
                    nmber: TextInputType.text,
                    validator: controller.validateArea,
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                    controller: controller.nerarByController,
                    hintText: AppConstentData.nearby,
                    labelText:  AppConstentData.nearby, isHint: false,
                    nmber: TextInputType.text,
                    validator: controller.validateNearBy,
                    bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(onPressed: () async{
                      controller.saveLocation();
                  },
                    title: AppConstentData.saveadd,
                      colors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), isLoading: false,),
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

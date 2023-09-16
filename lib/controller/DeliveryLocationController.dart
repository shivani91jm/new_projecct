import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
class DeliveryLocationController extends GetxController{
  TextEditingController flatController=TextEditingController();
  TextEditingController areaController=TextEditingController();
  TextEditingController nerarByController=TextEditingController();
  TextEditingController houseNoController=TextEditingController();
   TextEditingController selectLocationController=TextEditingController();
  var selectedValue = ''.obs;
  var latitude=''.obs;
  var longitude=''.obs;
  var addressController=''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }
  void saveLocation() async {
    if(formKey.currentState!.validate())
      {

      }

  }
//-----------------select location --------------------------------
  void selectLocation(){

    }
  String? validateFlatOrHouseNo(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.flathouseno);
    }

    return null;
  }
  String? validateArea(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.areasectorlocatity);
    }

    return null;
  }
  String? validateNearBy(String? value) {
    return null;
  }


}
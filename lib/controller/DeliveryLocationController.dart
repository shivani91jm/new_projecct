import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DeliveryLocationController extends GetxController{

   TextEditingController selectLocationController=TextEditingController();
  var selectedValue = 'Myself'.obs;
  var latitude=''.obs;
  var longitude=''.obs;
  var addressController=''.obs;
  var typeAreaLikeHome=''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }
  //-------------------save address----------------------
  void saveLocation() async {


  }
//-----------------select current location --------------------------------
   selectLocation(String currentlocation) async{
    final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentLocation',currentlocation);

    }
  String? validateFlatOrHouseNo(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.flathouseno);
    }
    else {
      return null;
    }
  }
  String? validateArea(String? value) {
    if (value!.isEmpty) {
      return CommonUtilsClass.toastMessage("" + AppConstentData.areasectorlocatity);
    }
    else {
      return null;
    }
  }
  String? validateNearBy(String? value) {
    return null;
  }


}
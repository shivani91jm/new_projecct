import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

//-----------------select current location --------------------------------
   selectLocation(String place) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('address_1', place.toString());
      prefs.setString('address_2', "");
      var msg=  prefs.getString("address_1")??"";
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
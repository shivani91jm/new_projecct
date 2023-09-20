import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  var typeAreaLikeHome=''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }
  //-------------------save address----------------------
  void saveLocation() async {
    if(formKey.currentState!.validate())
      {
        var flatno=flatController.text;
        var area=areaController.text;
        var nearby=nerarByController.text;
        var houseno=houseNoController.text;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('type',typeAreaLikeHome.value);
        prefs.setString("flat", flatno);
        prefs.setString("area", area);
        prefs.setString("houseno", houseno);
        prefs.setString("nearby", nearby);
      }

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
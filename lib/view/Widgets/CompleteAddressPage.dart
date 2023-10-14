import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteAddressPage extends StatefulWidget {
  var data;
  CompleteAddressPage({Key? key,required this.data});

  @override
  State<CompleteAddressPage> createState() => _CompleteAddressPageState();
}

class _CompleteAddressPageState extends State<CompleteAddressPage> {

  DeliveryLocationController controller=Get.put(DeliveryLocationController());
  var flag_apge="";
  String page_name="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   flag_apge= widget.data['flag_page'];
   page_name=widget.data['page_name'];
  }

  TextEditingController flatController=TextEditingController();
  TextEditingController areaController=TextEditingController();
  TextEditingController nerarByController=TextEditingController();
  TextEditingController houseNoController=TextEditingController();
  RxBool loading=false.obs;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
        title: Text(
          "Complete Address",
          style: TextStyle(
            color: AppColors.whiteColors
          ),
        ),
      ),
      body:  SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
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

                      ),),
                      value: 'Myself',
                      groupValue: controller.selectedValue.value,
                      onChanged: (value) {
                        controller.selectedValue.value=value!;
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

                      ),),
                      value: 'Someone else',
                      groupValue: controller.selectedValue.value,
                      onChanged: (value) {
                        controller.selectedValue.value=value!;
                      },
                    ),),
                    Text(AppConstentData.saveasaddress,style: TextStyle(
                        color: AppColors.blackColors,
                        fontSize: AppSizeClass.maxSize14,
                        fontWeight: FontWeight.bold,

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
                          return 'Enter Flat / house no';
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
                          return 'Enter Area / sector /locality';
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
                    SizedBox(
                      height: 20,
                    ),
                  Obx(() =>   CustomButton(onPressed: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if(formKey.currentState!.validate())
                    {
                        var area=areaController.text;
                        var houseno=houseNoController.text;
                        await prefs.setString('address_1',area.toString());
                        await prefs.setString('address_2', houseno.toString());
                        CommonUtilsClass.toastMessage("Save Location");

                        if(flag_apge=="2") {
                          Navigator.pushReplacementNamed(context, RouteNames.addtocart_screen);
                        }
                        else
                        {
                          Navigator.pop(context,"");
                        }
                    }
                  },
                    title: loading.value?"": AppConstentData.saveadd ,
                    colors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), isLoading: loading,),
                  ),         // Add more list items here
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

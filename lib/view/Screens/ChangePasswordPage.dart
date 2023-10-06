import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/ForgetPasswordController.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ForgetPasswordController controller=Get.put(ForgetPasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  var email="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(text: AppConstentData.changePassword,
                height: 300,
                flag: true,
              ),
              Card(
                elevation: 4,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        //---------------new password-----------------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInputFields(
                            controller: passwordController,
                            hintText: AppConstentData.Password,
                            labelText:  AppConstentData.Password,
                            isHint: true,
                            nmber: TextInputType.visiblePassword,
                            validator: (value){
                              if(value!.isEmpty) {
                                return 'Enter   Password';
                              }
                              else if(value.toString().length<3)
                              {
                                return 'Password should be longer or equal to 3 characters';
                              }
                              else
                                {
                                  return null;
                                }
                            },
                            bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                            textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), enable: true,
                          ),
                        ),
                        //----------------- confirm password------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInputFields(
                            controller: confirmPassController,
                            hintText: AppConstentData.ConPassword,
                            labelText:  AppConstentData.ConPassword, isHint: true,
                            nmber: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty) {
                                return 'Enter Confirm  Password';
                              }
                              else if(value.toString().length<3)
                                {
                                  return 'Password should be longer or equal to 3 characters';
                                }
                              else if(value.toString()!=passwordController.text)
                                {
                                  return 'Password not matched';
                                }
                              else
                                {
                                  return null;
                                }
                            },
                            enable: true,
                            bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                            textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
                              child: Obx(() => CustomButton(
                                onPressed: () async{
                                  String text=confirmPassController.text;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  email=   prefs.getString('email')?? "";
                                  if(email!="" && email!="null") {
                                    if(formKey.currentState!.validate()) {
                                      controller.changePassword(email, text);
                                    }
                                  }
                                  else
                                    {
                                      Get.snackbar(
                                        "Please Login or Signup",
                                        "",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                        borderRadius: 5,
                                        margin: EdgeInsets.all(5),
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 4),
                                        isDismissible: true,
                                        forwardAnimationCurve: Curves.easeOutBack,
                                      );
                                    }
                                },
                                title:controller.loading.value?"": AppConstentData.changePassword,
                                colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                isLoading: controller.loading,
                              ),)
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


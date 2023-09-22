import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/ConatctUsController.dart';
import 'package:new_projecct/view/Widgets/AppDetailsPage.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
class ConatctUsPage extends StatefulWidget {
  const ConatctUsPage({super.key});
  @override
  State<ConatctUsPage> createState() => _ConatctUsPageState();
}

class _ConatctUsPageState extends State<ConatctUsPage> {
  ContactUsController controller =Get.put(ContactUsController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController megController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppDetailsPage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------app bar--------------
            CustomAppBar(text: AppConstentData.contactUu, height: 300, flag: true,),
            //-------------------body contaner -----------------
            Container(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text("If you have any question for us, please drop us a message via below contact form.",
                        style: TextStyle(
                            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                            fontFamily: "NotoSerif",
                            fontSize: AppSizeClass.maxSize16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //--------------------name controller --------------------
                      TextInputFields(
                        controller: nameController,
                        hintText: AppConstentData.UserName,
                        labelText:  AppConstentData.UserName, isHint: false,
                        nmber: TextInputType.text,
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Enter Username';
                          }
                          else{
                            return null;
                          }
                        },
                        bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                        textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //--------------email ----------------
                      TextInputFields(
                        controller: emailController,
                        hintText: AppConstentData.entermsg,
                        labelText:  AppConstentData.entermsg, isHint: false,
                        nmber: TextInputType.emailAddress,
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Enter email';
                          } else if(!value.contains("@")){
                            return "Enter valid email";
                          }
                          else{
                            return null;
                          }
                        },
                        bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                        textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //----------------------Meg controller ---------------------
                      TextInputFields(
                        controller: megController,
                        hintText: AppConstentData.entermsg,
                        labelText:  AppConstentData.entermsg, isHint: false,
                        nmber: TextInputType.text,
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Enter any query';
                          }
                          else{
                            return null;
                          }
                        },
                        bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                        textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onPressed: () async
                        {
                          if(formKey.currentState!.validate())
                            {
                              String name=nameController.text;
                              String email=emailController.text;
                              String subject=megController.text;
                              controller.submitContactDetails(name,email,subject);
                            }
                        },
                        title: AppConstentData.submit,
                        colors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        isLoading: false.obs,
                      )

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

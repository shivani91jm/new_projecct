import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CheckInternetController.dart';
import 'package:new_projecct/controller/ForgetPasswordController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';


class ForgetPassword extends StatefulWidget {
   ForgetPassword({super.key});
   @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final CheckInternetController _controller = Get.find<CheckInternetController>();
   ForgetPasswordController controller=Get.put(ForgetPasswordController());
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   @override
  Widget build(BuildContext context) {
      return Obx(() => _controller.connectionType.value == 1 ? datawiget() : _controller.connectionType.value == 2 ?  datawiget() : NoInternetClass(page: RouteNames.forgetpassword_screen,));
   }
   Widget datawiget(){
     return SafeArea(
       child: Scaffold(
         appBar: AppBar(
           backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
         ),
         bottomNavigationBar: Container(
           height: 50,
           margin: EdgeInsets.all(10),
           child: Padding(
             padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
             child: Obx(() => CustomButton(
               onPressed: () async{
                 controller.checkEmailExitsOrNot(_formKey);
               },
               title: controller.loading.value?"Forget"
                   "": AppConstentData.continues,
               colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR), isLoading: controller.loading,
             )),
           ),
         ),
         body: SingleChildScrollView(
           child: Form(
             key: _formKey,
             child: Container(
               margin: EdgeInsets.all(10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     margin: EdgeInsets.all(10),
                     height: 300,
                     child: Image.asset(ImageUrls.password_url),
                   ),
                   Container(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Align(
                           child:  Text(AppConstentData.forgetPassword,
                             style: TextStyle(
                                 fontSize: AppSizeClass.maxSize25,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "NotoSerif",
                                 color: GradientHelper.getColorFromHex(AppColors.RED_COLOR)
                             ),
                           ),
                           alignment: Alignment.center,
                         ),
                         SizedBox(
                           height: 5,
                         ),
                         Align(
                           child:  Text(AppConstentData.forgetdetails,
                             style: TextStyle(
                                 fontSize: AppSizeClass.maxSize15,
                                 fontWeight: FontWeight.w400,
                                 fontFamily: "NotoSerif",
                                 color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)
                             ),
                           ),
                           alignment: Alignment.center,
                         ),
                         SizedBox(
                           height: 40,
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextInputFields(
                             enable: true,
                             controller: controller.editingController,
                             hintText: AppConstentData.Email,
                             labelText:  AppConstentData.Email, isHint: false,
                             nmber: TextInputType.emailAddress,
                             validator: (value){
                               if(value!.isEmpty)
                                 {
                                   return "Email is required !!";
                                 }
                               else if(!value.contains("@")){
                                 return "Enter valid email";
                               }
                               else{
                                 return null;
                               }

                             },
                             bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                             textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
         ),
       ),
     );
   }
}

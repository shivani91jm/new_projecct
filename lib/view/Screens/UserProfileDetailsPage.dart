import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/UpdateUserProfileController.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
class UserProfileDetails extends StatefulWidget {
  const UserProfileDetails({super.key});
  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}
class _UserProfileDetailsState extends State<UserProfileDetails> {
  UpdateUserProfileController controller = Get.put(UpdateUserProfileController());
    final double coverHeight=230;
    final double circleHeight=140;
    @override
  Widget build(BuildContext context) {
    final top =coverHeight-circleHeight/2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children:<Widget>[
                CustomAppBar(text: "", height: coverHeight, flag: true,),
                Positioned(
                    top: top,
                  child:  datacgfgh()
                ),
              ]
            ),
              Container(
                margin: EdgeInsets.fromLTRB(15,70,15,10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,0.0),
                        child: Text("User Name",
                          style: TextStyle(
                          color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          fontWeight: FontWeight.bold,
                            fontSize: AppSizeClass.maxSize25
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("user@gmail.com",
                        style: TextStyle(
                            color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            fontWeight: FontWeight.w300,
                            fontSize: AppSizeClass.maxSize16
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),
                    Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(AppConstentData.updateProfile,
                          style: TextStyle(
                              color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                              fontFamily: "NotoSerif",
                              fontSize: AppSizeClass.maxSize20,
                              fontWeight: FontWeight.bold,


                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        // //--------------------name controller --------------------
                        TextInputFields(
                          controller: controller.nameController,
                          hintText: AppConstentData.UserName,
                          labelText:  AppConstentData.UserName, isHint: false,
                          nmber: TextInputType.text,
                          validator: controller.validatePassword,
                          bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //--------------email  controller ----------------
                        TextInputFields(
                          controller: controller.emailController,
                          hintText: AppConstentData.entermsg,
                          labelText:  AppConstentData.entermsg, isHint: false,
                          nmber: TextInputType.emailAddress,
                          validator: controller.validatePassword,
                          bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            onPressed: () async{},
                            title: AppConstentData.updateProfile,
                            colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                            isLoading: false.obs)
                      ],
                    ),
                  )

                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

 Widget wifgeeee() {
    return  Container(
        height: coverHeight,
        color: AppColors.blackColors,
        child: Container(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: (){
                Navigator.pop(context,"");
              }, icon:Icon(
                Icons.arrow_back_ios_new,
                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),

              )),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("text",style: TextStyle(
                  color: AppColors.whiteColors,
                  fontFamily: "NotoSerif",
                  fontSize: AppSizeClass.maxSize30,
                  fontWeight: FontWeight.bold
              ),),
            ),


          ],
        )
        ));
  }
  Widget datacgfgh() {
    return CircleAvatar(
      radius: circleHeight/2,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppSizeClass.maxSize25)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(ImageUrls.google_url),
              ],
            ),
          )
      ),
    );
 }
}

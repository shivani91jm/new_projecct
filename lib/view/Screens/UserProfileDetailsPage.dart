import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/UpdateUserProfileController.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserProfileDetails extends StatefulWidget {
  const UserProfileDetails({super.key});
  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}
class _UserProfileDetailsState extends State<UserProfileDetails> {
  UpdateUserProfileController controller = Get.put(UpdateUserProfileController());
    final double coverHeight=240;
    final double circleHeight=100;
    var email="",username="",usermobile="";
    var first_name="", last_name="";
  File? galleryFile;
  String file_path="";
  String user_id="";
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }
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
                margin: EdgeInsets.fromLTRB(15,40,15,10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,0.0),
                        child: Text(""+first_name,
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
                      child: Text(""+email,
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

                              fontSize: AppSizeClass.maxSize20,
                              fontWeight: FontWeight.bold,


                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        // //--------------------name controller --------------------
                        TextInputFields(
                          controller: controller.firstController,
                          hintText: AppConstentData.UserName,
                          labelText:  AppConstentData.UserName, isHint: false,
                          nmber: TextInputType.text,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return 'First Name is Empty';
                              }
                            else
                              {
                                return null;
                              }
                          },
                          bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                          enable: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //--------------email  controller ----------------
                        TextInputFields(
                          controller: controller.lastController,
                          hintText: "Enter Last Name",
                          labelText:  "Enter Last Name", isHint: false,
                          nmber: TextInputType.emailAddress,
                          validator: (value){
                            return null;
                          },
                          bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), enable: true,
                        ),
                        //-----------------mobile number ---------------------
                        SizedBox(
                          height: 20,
                        ),
                        //--------------email  controller ----------------
                        TextInputFields(
                          controller: controller.mobileController,
                          hintText: 'Enter Mobile Number',
                          labelText:  'Enter Mobile Number', isHint: false,
                          nmber: TextInputType.phone,
                            validator: (value){
                                  return null;
                               },
                          bordercolors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                          textcolors: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), enable: true,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                         Obx(() =>  CustomButton(
                           onPressed: () async{

                             SharedPreferences prefs = await SharedPreferences.getInstance();
                             email=   prefs.getString('email')?? "";
                             if(email!="" && email!="null") {
                               String firstname=controller.firstController.text;
                               String lastname=controller.lastController.text;
                               String mobile=controller.mobileController.text;
                               if(file_path!="" && file_path!="null") {
                                 controller.userUpdate(firstname, lastname, mobile, file_path,user_id);
                               }
                               else
                                 {
                                     CommonUtilsClass.toastMessage("Please Select Image");
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
                           title: controller.loading.value?"update profile":AppConstentData.updateProfile,
                           colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                           isLoading: controller.loading
                       ))
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

                  fontSize: AppSizeClass.maxSize30,
                  fontWeight: FontWeight.bold
              ),),
            ),


          ],
        )
        ));
  }
  Widget datacgfgh() {
    return GestureDetector(
      onTap: (){
        _showPicker(context: context);
      },
      child: CircleAvatar(
        backgroundColor: AppColors.whiteColors,
        radius: circleHeight/2,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(AppSizeClass.maxSize25)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  galleryFile == null ?  Center(child: Container(
                    width: 150.0,
                    height: 80.0,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        image: AssetImage(ImageUrls.profile_url,), // Replace with your image path
                        fit: BoxFit.cover,
                      ),

                    ),
                  )) : Center(child: Image.file(galleryFile!))

                ],
              ),
            )
        ),
      ),
    );
 }
  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     email=   prefs.getString('email')?? "";
     username = prefs.getString('username')?? "";
     usermobile = prefs.getString('mobile_number')?? "";
     first_name = prefs.getString("user_firstName")??"";
     last_name = prefs.getString("user_lastName")??"";
     user_id = prefs.getString("user_id")??"";
     print("data value"+email.toString()+"username"+username+"mobile"+usermobile);
     controller.firstController.text=first_name.toString();
     controller.lastController.text=last_name.toString();
     if(usermobile.toString()!="null") {
       controller.mobileController.text = usermobile.toString();
     }
     else
       {
         controller.mobileController.text ="";
       }
     if(first_name.toString()!="null") {
       controller.firstController.text = first_name.toString();
     }
     else
       {
         controller.firstController.text ="";
       }
     if(last_name.toString()!="null") {
       controller.lastController.text = last_name.toString();
     }
     else
       {
         controller.lastController.text ="";
       }

   });

  }
  Future getImage(ImageSource img,) async {
    final pickedFile = await ImagePicker().pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
          file_path=pickedFile!.path;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
  void _showPicker({required BuildContext context,}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

}

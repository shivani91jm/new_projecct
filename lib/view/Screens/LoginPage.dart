import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CheckInternetController.dart';
import 'package:new_projecct/controller/LoginController.dart';
import 'package:new_projecct/services/google_singin.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final CheckInternetController _controller = Get.find<CheckInternetController>();
  String string = '';
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  LoginController controller=Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ? datawiget() : _controller.connectionType.value == 2 ?  datawiget() : NoInternetClass(page: RouteNames.login_screen,));

  }
  Widget datawiget() {
    LinearGradient gradient = GradientHelper.getGradientFromStringColor(AppColors.RED_COLOR,AppColors.Red_drak_COLOR);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
        actions: [
          GestureDetector(
            onTap: () async{
              Navigator.pushReplacementNamed(context, RouteNames.dashboard_screen);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                color: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
              ),
              child:  Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,15,20,8.0),
                    child:  Text(AppConstentData.Skip,
                      style: TextStyle(
                          fontSize: AppSizeClass.maxSize17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "NotoSerif",
                          color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: gradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: GradientHelper.getColorFromHex(AppColors.Box_BORDER_COLOR) ,
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        height: 100,
                        width: 300,
                        ImageUrls.logo_url,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextInputFields(
                            enable: true,
                            controller: emailController,
                            hintText: AppConstentData.Email,
                            labelText:  AppConstentData.Email, isHint: false,
                            nmber: TextInputType.emailAddress,
                            bordercolors: AppColors.whiteColors,
                            textcolors: AppColors.whiteColors,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              } else if(!value.contains("@")){
                                return "Enter valid email";
                              }
                              else{
                                return null;
                              }
                            },),
                          SizedBox(
                            height: 20,
                          ),
                          TextInputFields(
                            enable: true,
                            controller: passwordController,
                            hintText: AppConstentData.Password,
                            labelText:  AppConstentData.Password, isHint: true,
                            nmber: TextInputType.visiblePassword,
                            bordercolors: AppColors.whiteColors,
                            textcolors: AppColors.whiteColors, validator: (value ) {
                            if (value.toString().length < 3) {
                              return 'Password should be longer or equal to 3 characters'
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() =>  CustomButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                var email=emailController.text;
                                var password=passwordController.text;
                                controller.loginApi(email, password);
                              }

                            }, title: controller.loading.value?"Login": AppConstentData.Login,
                            colors:  GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            isLoading: controller.loading,
                          ),),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, RouteNames.forgetpassword_screen);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(AppConstentData.forgetPassword,
                                  style: TextStyle(
                                    color: AppColors.whiteColors,

                                  ),),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration:  BoxDecoration(
                                  color: AppColors.whiteColors,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppColors.whiteColors ,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    GoogleSinginClass.signup(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.whiteColors,
                                      child: Image.asset(
                                          height: 20,
                                          width: 20,
                                          ImageUrls.google_url
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration:  BoxDecoration(
                                  color: AppColors.whiteColors,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppColors.whiteColors ,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () async{
                                    CommonUtilsClass.toastMessage('Coming Soon...');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.whiteColors,
                                      child: Image.asset(
                                          height: 20,
                                          width: 20,
                                          ImageUrls.facebook_url
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context!,RouteNames.registration_screen);
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:  const EdgeInsets.fromLTRB(8,8.0,3.0,8.0),
                                    child: Text(AppConstentData.noaccount,style: TextStyle(
                                        color: AppColors.whiteColors,
                                        fontFamily: "NotoSerif",
                                        fontSize: AppSizeClass.maxSize16
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8.0,8.0,8.0),
                                    child: Text(AppConstentData.SignUp,style: TextStyle(
                                        color: AppColors.whiteColors,
                                        fontFamily: "NotoSerif",
                                        fontSize: AppSizeClass.maxSize16
                                    ),),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return email.isNotEmpty && email.contains('@');
  }
  bool isValidPassword(String password) {

    return password.length >= 6;
  }
  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }

}

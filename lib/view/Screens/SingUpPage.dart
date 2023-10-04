import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/SignUpController.dart';
import 'package:new_projecct/services/google_singin.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/TextInputFeildClass.dart';
class SingUpPage extends StatefulWidget {
  SingUpPage({super.key});
  @override
  State<SingUpPage> createState() => _SingUpPageState();
}
class _SingUpPageState extends State<SingUpPage> {
  SignUpController controller=Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _currentAddress;
  Position? _currentPosition;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController lastnameController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleLocationPermission(context);
    _getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = GradientHelper.getGradientFromStringColor(AppColors.RED_COLOR,AppColors.Red_drak_COLOR);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: gradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
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
                  height: 30,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          //-----------------first name----------------
                          TextInputFields(
                            enable: true,
                            controller: usernameController,
                            hintText: AppConstentData.UserName,
                            labelText:  AppConstentData.UserName, isHint: false,
                            nmber: TextInputType.text,
                           validator: (value){
                             if (value!.isEmpty) {
                               return 'Enter First Name';
                             }
                            else {
                               return null;
                             }
                           },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //-----------------------last name ------------------
                          TextInputFields(
                            enable: true,
                            controller: lastnameController,
                            hintText: "Enter Last Name",
                            labelText: "Enter Last Name", isHint: false,
                            nmber: TextInputType.text,
                            validator: (value){
                              if (value!.isEmpty) {
                                return "Enter Last Name";
                              }
                              else {
                                return null;
                              }
                            },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //----------------email ---------------------
                          TextInputFields(
                            enable: true,
                            controller: emailController,
                            hintText: AppConstentData.Email,
                            labelText:  AppConstentData.Email, isHint: false,
                            nmber: TextInputType.emailAddress,
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              else if(!value.contains("@")){
                                return "Enter valid email";
                              }
                              else{
                                return null;
                              }
                            },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //----------------------password ------------------------
                          TextInputFields(
                            enable: true,
                            controller: passwordController,
                            hintText: AppConstentData.Password,
                            labelText:  AppConstentData.Password, isHint: true,
                            nmber: TextInputType.visiblePassword,
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              }
                              if (value.toString().length < 3) {
                                return 'Password should be longer or equal to 3 characters'
                                    .tr;
                              } else {
                                return null;
                              }


                            },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //-----------------mobile number------------------
                          TextInputFields(
                            enable: true,
                            controller: mobileController,
                            hintText: AppConstentData.Moboile,
                            labelText:  AppConstentData.Moboile, isHint: false,
                            nmber: TextInputType.phone,
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Enter Mobile';
                              }
                              // else if(value.toString().length!=12)
                              //   {
                              //     return 'Enter only 12 digit';
                              //   }

                              return null;
                            },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //---------------------address controller-----------
                          TextInputFields(
                            enable: true,
                            controller: addressController,
                            hintText: AppConstentData.address,
                            labelText:  AppConstentData.address, isHint: false,
                            nmber: TextInputType.text,
                            validator: (value){
                              return null;
                            },
                            bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() =>   CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var firstname=usernameController.text;
                                var lastname=lastnameController.text;
                                var email=emailController.text;
                                var password=passwordController.text;
                                var mobile=mobileController.text;
                                var add= addressController.text;
                                  controller.singUpApi(firstname,lastname,email,password,mobile,add);
                              }
                              }, title: controller.loading.value?"SignUp": AppConstentData.SignUp,
                            colors:  GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR), isLoading: controller.loading,
                          ),),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            GestureDetector(
                              onTap:(){
                                GoogleSinginClass.signup(context);
                              },
                              child:   Container(
                                decoration:  BoxDecoration(
                                  color: AppColors.whiteColors,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppColors.whiteColors ,
                                  ),),
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
                              GestureDetector(
                                onTap: (){
                                  CommonUtilsClass.toastMessage('Coming Soon...');
                                },
                                child: Container(
                                  decoration:  BoxDecoration(
                                    color: AppColors.whiteColors,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: AppColors.whiteColors ,
                                    ),

                                  ),
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
                            onTap: () async{
                              Navigator.pushNamed(context!,RouteNames.login_screen);
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:  const EdgeInsets.fromLTRB(8,8.0,3.0,8.0),
                                    child: Text(AppConstentData.alreadyaccount,style: TextStyle(
                                        color: AppColors.whiteColors,
                                        fontFamily: "NotoSerif",
                                        fontSize: AppSizeClass.maxSize16
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8.0,8.0,8.0),
                                    child: Text(AppConstentData.Login,style: TextStyle(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);

    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
          controller.latitude=_currentPosition!.latitude.toString();
          controller.longitude=_currentPosition!.longitude.toString();
      Placemark place = placemarks[0];
      print("address"+place.toString());
      setState(() {
        addressController.text = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        print("address"+_currentAddress.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}


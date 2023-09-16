import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/SignUpController.dart';
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
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            //-----------------username----------------
                            TextInputFields(
                              controller: controller.usernameController,
                              hintText: AppConstentData.UserName,
                              labelText:  AppConstentData.UserName, isHint: false,
                              nmber: TextInputType.text,
                              validator: controller.validateUserName,
                              bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //----------------email ---------------------
                            TextInputFields(
                              controller: controller.emailController,
                              hintText: AppConstentData.Email,
                              labelText:  AppConstentData.Email, isHint: false,
                              nmber: TextInputType.emailAddress,
                              validator: controller.validateEmail,
                              bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //----------------------password ------------------------
                            TextInputFields(
                              controller: controller.passwordController,
                              hintText: AppConstentData.Password,
                              labelText:  AppConstentData.Password, isHint: true,
                              nmber: TextInputType.visiblePassword,
                              validator: controller.validatePassword,
                              bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //-----------------mobile number------------------
                            TextInputFields(
                              controller: controller.mobileController,
                              hintText: AppConstentData.Moboile,
                              labelText:  AppConstentData.Moboile, isHint: false,
                              nmber: TextInputType.phone,
                              validator: controller.validateMobile,
                              bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //---------------------address controller-----------
                            TextInputFields(
                              controller: controller.addressController,
                              hintText: AppConstentData.address,
                              labelText:  AppConstentData.address, isHint: false,
                              nmber: TextInputType.text,
                              validator: controller.validateAddress,
                              bordercolors: AppColors.whiteColors, textcolors: AppColors.whiteColors,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // CustomButton(
                            //   onPressed: () {
                            //     controller.singupandvalidate(_formKey);
                            //   }, title: AppConstentData.SignUp,
                            //   colors:  GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            // ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CircleAvatar(
                                      child: Image.asset(
                                          height: 20,
                                          width: 20,
                                          ImageUrls.google_url
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CircleAvatar(
                                      child: Image.asset(
                                          height: 20,
                                          width: 20,
                                          ImageUrls.facebook_url
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
          ],
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
        controller.addressController.text = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        print("address"+_currentAddress.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}


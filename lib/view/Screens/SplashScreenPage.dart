import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacementNamed(context,RouteNames.location_screen));
  }
  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = GradientHelper.getGradientFromStringColor(AppColors.RED_COLOR,AppColors.Red_drak_COLOR);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        gradient: gradient,
    ),
    child: Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           Container(
             decoration:  BoxDecoration(
               color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
               borderRadius: BorderRadius.circular(25),
               border: Border.all(
                   color: GradientHelper.getColorFromHex(AppColors.Box_BORDER_COLOR) ,
               ),
             ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Image.asset(
                 height: 100,
                 width: 300,
                 ImageUrls.logo_url,
               ),
             ),
           ),
          ],
        )
      ),
    ),
      ),
    );
  }
}


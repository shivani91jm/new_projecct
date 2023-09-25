import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RouteesPages.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CartProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp(), // Wrap your app
        ));
      });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:GradientHelper.getColorFromHex(AppColors.RED_COLOR), // Status bar background color
      statusBarIconBrightness: Brightness.light, // Status bar text color (dark or light)
    ));
  return ChangeNotifierProvider(create: (_)=> CartProvider(),
    child: Builder(builder: (BuildContext context){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutePages.generateRoute,
        initialRoute: RouteNames.splash_screen,
      );
    }),
  );
  }
}



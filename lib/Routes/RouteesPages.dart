import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/view/Screens/AboutUs.dart';
import 'package:new_projecct/view/Screens/AllOrdersPage.dart';
import 'package:new_projecct/view/Screens/ChangePasswordPage.dart';
import 'package:new_projecct/view/Screens/ContactUsPage.dart';
import 'package:new_projecct/view/Screens/DashBoardPage.dart';
import 'package:new_projecct/view/Screens/DeliveryLocationPage.dart';
import 'package:new_projecct/view/Screens/ForgetPasswordPage.dart';
import 'package:new_projecct/view/Screens/Fragments/CardPage.dart';
import 'package:new_projecct/view/Screens/Fragments/ProductDetailsPage.dart';
import 'package:new_projecct/view/Screens/LoginPage.dart';
import 'package:new_projecct/view/Screens/SelectLocationPage.dart';
import 'package:new_projecct/view/Screens/ShopLocationPage.dart';
import 'package:new_projecct/view/Screens/SingUpPage.dart';
import 'package:new_projecct/view/Screens/UserProfileDetailsPage.dart';
import 'package:new_projecct/view/Screens/testclover.dart';
class RoutePages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash_screen:
    return MaterialPageRoute(builder: (_) => TextClover());
    case RouteNames.login_screen:
    return MaterialPageRoute(builder: (_) => LoginPage());
    case RouteNames.dashboard_screen:
    return MaterialPageRoute(builder: (_) => DashBoardPage());
    case RouteNames.registration_screen:
    return MaterialPageRoute(builder: (_) => SingUpPage());
    case RouteNames.location_screen:
    return MaterialPageRoute(builder: (_) => ShopLocationPage());
    case RouteNames.productdetails_screen:
    return MaterialPageRoute(builder: (_) => ProductDetailsPage(data:settings.arguments as Map));
    case RouteNames.addtocart_screen:
    return MaterialPageRoute(builder: (_) => AddToCartPage());
    case RouteNames.delivery_screen:
    return MaterialPageRoute(builder: (_) => DeliveryLocationPage());
    case RouteNames.complete_address_screen:
    return MaterialPageRoute(builder: (_) => SelectLocationPage());
    case RouteNames.aboutus_screen:
    return MaterialPageRoute(builder: (_) => AboutUsPage());
    case RouteNames.contactus_screen:
    return MaterialPageRoute(builder: (_) => ConatctUsPage());
    case RouteNames.allOrders_screen:
    return MaterialPageRoute(builder: (_) => AllOrdersPage());
    case RouteNames.allOrders_screen:
    return MaterialPageRoute(builder: (_) => AllOrdersPage());
    case RouteNames.userProfile_screen:
    return MaterialPageRoute(builder: (_) => UserProfileDetails());
    case RouteNames.changepassword_screen:
    return MaterialPageRoute(builder: (_) => ChangePassword());
    case RouteNames.forgetpassword_screen:
    return MaterialPageRoute(builder: (_) => ForgetPassword());
    default:
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Text("No Routes Declare"),
        ),
      );
    });
    }
  }
}
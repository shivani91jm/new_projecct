import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/CheckInternetController.dart';

import 'package:new_projecct/view/Screens/Fragments/CardPage.dart';
import 'package:new_projecct/view/Screens/Fragments/HomePage.dart';
import 'package:new_projecct/view/Screens/Fragments/SettingPage.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';
class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<Widget> _screen = [
     HomePage(),
    AddToCartPage(),
    SettingPage(),
  ];
  List _bottomNavigationProperties = [
    {
      "active_icon":Icons.home,
      "non_active_icon":Icons.home_outlined,
      "label":"Home"
    },

    {
      "active_icon":Icons.shopping_cart,
      "non_active_icon":Icons.shopping_cart_checkout,
      "label":"Card"
    },
    {
      "active_icon":Icons.settings,
      "non_active_icon":Icons.settings,
      "label":"Settings"
    },

  ];
  RxInt _indexNumber=0.obs;
  final CheckInternetController _controller = Get.find<CheckInternetController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
            bottomNavigationBar: Container(
            decoration: BoxDecoration(
            color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
            borderRadius:BorderRadius.all(Radius.circular(40)),

            ),
            child: Obx(()=> BottomNavigationBar(
            backgroundColor:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
            type: BottomNavigationBarType.fixed,
            items: List.generate(3, (index) {
            var navBtnProperties=_bottomNavigationProperties[index];
            return BottomNavigationBarItem(
            icon: Icon(navBtnProperties['non_active_icon']),
            activeIcon: Icon(navBtnProperties['active_icon']),
            label: navBtnProperties["label"]
            );

            } ),
            currentIndex: _indexNumber.value,
            onTap: (value){
            _indexNumber.value=value;
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.whiteColors,
            unselectedItemColor: AppColors.whiteColors,
      )
     ),
    ),
    body: Obx(() => _controller.connectionType.value == 1 ? datawiget() : _controller.connectionType.value == 2 ?  datawiget() : NoInternetClass(page: RouteNames.dashboard_screen,))) ,);
  }
  Widget datawiget(){
    return  Obx(() => _screen[_indexNumber.value]);
  }
  Future<bool> _onWillPop() async {
    return (
        await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 3,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Align(alignment:Alignment.center,
        child: Text('Exit App',
          style: TextStyle(
            fontSize: AppSizeClass.maxSize17,
            fontWeight: FontWeight.bold,
            fontFamily: "NotoSerif",
            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          ),
        )),
        content: Container(
            height: 200,
            decoration: BoxDecoration(),
            child: Column(
              children: [
               Container(

                 child:  Image.asset(ImageUrls.extis_url),
                 height: 150,
               ),
                SizedBox(
                  height: 10,
                ),
                DividerWidgets(),
                SizedBox(
                  height: 10,
                ),
                Text('Do you want to exit the app?',
                  style: TextStyle(
                    fontSize: AppSizeClass.maxSize17,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NotoSerif",
                    color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                  ),

                ),
              ],
            )),
        actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                ),
              ),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: Text('Yes',
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                ),
              ),
            ),
          ],
        )
        ],
      ),
    )) ??
        false;
  }
}

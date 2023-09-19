import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/view/Screens/Fragments/AddToFavourites.dart';
import 'package:new_projecct/view/Screens/Fragments/CardPage.dart';
import 'package:new_projecct/view/Screens/Fragments/HomePage.dart';
import 'package:new_projecct/view/Screens/Fragments/SettingPage.dart';
class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<Widget> _screen = [
     HomePage(),
     FavouritesPage(),
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
      "active_icon":Icons.restaurant_menu_outlined,
      "non_active_icon":Icons.restaurant_menu_sharp,
      "label":"Menu"
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
          borderRadius:BorderRadius.all(Radius.circular(40)),

        ),
        child: Obx(
                ()=> BottomNavigationBar(
                  backgroundColor:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  type: BottomNavigationBarType.fixed,
              items: List.generate(4, (index) {
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
      body: Obx(() => _screen[_indexNumber.value]),
    );
  }
}

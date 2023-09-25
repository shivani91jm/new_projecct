import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/ManuController.dart';
import 'package:new_projecct/view/Widgets/AllMenuAppBar.dart';
class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  MenuControllers controller=Get.put(MenuControllers());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.allCategories();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // You can set it back to the default color
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
    // ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------custom app bar ----------------
            AllMenuAppBar(),
            showAllCategories(),

          ],
        ),
      ),
    );
  }

 Widget showAllCategories() {
    return  Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.datass!.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child:Center(
                    child: Text(controller.datass[index].name.toString(),
                      style: TextStyle(
                        fontSize: AppSizeClass.maxSize20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NotoSerif",
                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

              ]
          );
        },
      )),
    );
 }
}

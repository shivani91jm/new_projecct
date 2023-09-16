import 'package:flutter/material.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
class NoInternetClass extends StatelessWidget {
 // final RouteNames. routename;

  const NoInternetClass({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizeClass.maxSize5,
      color: AppColors.whiteColors,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                  image: AssetImage(
                      ImageUrls.nointernet_url,

                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,10,10,10),
              child: Column(
                children: [
                  Text(
                    AppConstentData.nointernet,
                    style: TextStyle(
                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizeClass.maxSize25,
                    fontFamily: "NotoSerif",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppConstentData.checkinernet,
                    style: TextStyle(
                      color: AppColors.blackColors,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizeClass.maxSize18,
                      fontFamily: "NotoSerif",
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  // CustomButton(
                  //   onPressed: () async{
                  //     Navigator.pushNamed(context!,RouteNames.addtocart_screen);
                  //   }, title: AppConstentData.noconnection,
                  //   colors:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

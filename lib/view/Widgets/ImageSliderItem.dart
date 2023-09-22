import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/HomeController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/HomeAppBar.dart';
class ImageSliderItem  extends StatelessWidget {
  final String imagePath;
  final String address;
  HomeController controller;
  int currentPage;
  ImageSliderItem({required this.imagePath,required this.address,required this.controller,required this.currentPage});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
          ),
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 20, 30, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),

          ),
          child: Center(
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 280,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  // margin: EdgeInsets.all(20.0),
                  // padding: EdgeInsets.all(10.0), // Adjust padding as needed
                  // Adjust container background color and opacity
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(10.0,20,10,10.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WELCOME TO PAL RACHO',
                            style: TextStyle(fontSize: 20.0,
                                color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                fontWeight: FontWeight.bold,
                                fontFamily:'NotoSerif'
                            ),
                          ),
                          Text(
                            'Delicious Food & Wonderful Eating Experience',
                            style: TextStyle(fontSize: 15.0,
                                color: AppColors.blackColors,
                                fontWeight: FontWeight.w200,
                                fontFamily:'NotoSerif'

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.fromLTRB(12,8.0,12.0,8.0),
                              child: Text(
                                'Find My Store',
                                style: TextStyle(fontSize: 14.0,
                                    color: AppColors.whiteColors,
                                    fontWeight: FontWeight.w200,
                                    fontFamily:'NotoSerif'


                                ),
                              ),
                            ),)

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

}

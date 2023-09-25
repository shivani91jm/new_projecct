import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/CheckOutController.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutPage extends StatefulWidget {
  var data;
   CheckOutPage({super.key,required this.data});
   @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}
enum SingingCharacter { Cash, online }
class _CheckOutPageState extends State<CheckOutPage> {
  String currentLocation="";
  var page_flag="1";
  CheckOutController controller =Get.put(CheckOutController());
  SingingCharacter? _character = SingingCharacter.Cash;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      bottomNavigationBar: location(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                SizedBox(
                 height: 20,
               ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: AppColors.green,
                    elevation: 3,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: Colors.red, width: 15)),),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Add more items",
                                  style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "NotoSerif",
                                    color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                  )
                              ),
                            ),
                            Align(
                            child: IconButton(
                              onPressed: () async{

                            }, icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 17,
                              color: AppColors.green,
                            ),

                            ),
                          )
                          ],
                        ),

                      ),
                    ),
                ),
                SizedBox(
                    height: 10,
                 ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: AppColors.green,
                  elevation: 3,

                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Container(

                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.green, width: 15)),
                      ),
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Apply Coupons",
                                style: TextStyle(
                                  fontSize: AppSizeClass.maxSize17,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "NotoSerif",
                                  color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                                )
                            ),
                          ),
                          Align(
                            child: IconButton(
                              onPressed: () async{

                              }, icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                              size: 17,
                            ),

                            ),
                          )
                        ],
                      ),

                    ),
                  ),
                ),
                //---------------------your profile-----------------------------
                Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                shadowColor: AppColors.green,
                elevation: 3,
                  child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.cyan, width: 15)),
                    ),
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Your details", style: TextStyle(
                                fontSize: AppSizeClass.maxSize17,
                                fontWeight: FontWeight.normal,
                                fontFamily: "NotoSerif",
                                color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                              )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "NotoSerif",
                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                  Text("", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,

                                    fontFamily: "NotoSerif",
                                    color:AppColors.blackColors,
                                  )),

                                ],
                              )
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,8,0,0),
                            child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () async{

                                }, icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 17,
                              ),

                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget location() {
    return Container(
      height: 180,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                 Expanded(child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5.0,10.0,10.0,10.0),
                       child: Icon(Icons.location_on,
                           size: AppSizeClass.maxSize30,
                           color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)),
                     ),
                     Expanded(
                       child: Container(
                         child: Text(currentLocation,style: TextStyle(
                             color:AppColors.green,
                             fontWeight: FontWeight.bold,
                             fontSize: AppSizeClass.maxSize15
                         ),),
                       ),
                     )
                   ],
                 ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,5.0,10.0,0.0),
                      child: Text("change",style: TextStyle(
                          color:GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizeClass.maxSize15
                      ),),
                    )
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              DividerWidgets(),
              SizedBox(
                height: 20,
              ),
              if(page_flag=="1")...
                {
                   CustomButton(
                      onPressed: () async {
                          Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                            "page_flag":"2"
                          });
                       },
                       title:'Select Address at next step',
                      colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      isLoading: false.obs)
                }
                else...
                {
                   CustomButton(
                      onPressed: () async{

                      }, title:'Checkout',
                      colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      isLoading: false.obs
                   )
                }
            ],
          ),
        ),
      ),
    );
 }
  void getLocationValue()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocation=  prefs.getString('currentLocation')!;
  }
  void PaymentDialogBox(){
     showDialog(
         context: context,
         builder: (BuildContext context) {
           return Dialog(
             shape: RoundedRectangleBorder(
                 borderRadius:
                 BorderRadius.circular(20.0)), //this right here
             child: Container(
               height: 200,
               child: Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Select Payment Mode",style: TextStyle(
                       fontSize: AppSizeClass.maxSize20,
                       fontWeight: FontWeight.bold,
                       fontFamily: "NotoSerif",
                       color:AppColors.greyColors,
                     )),
                     RadioListTile<SingingCharacter>(
                       title: const Text('Cash'),
                       value: SingingCharacter.Cash,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                     RadioListTile<SingingCharacter>(
                       title: const Text('Credit/Debit/Net Banking /Upi'),
                       value: SingingCharacter.online,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                   ],
                 ),
               ),
             ),
           );
         });
   }
}

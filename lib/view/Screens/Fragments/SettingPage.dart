import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/DialogUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final double coverHeight=230;
  final double circleHeight=140;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // You can set it back to the default color
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final top =coverHeight-circleHeight/2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //---------------------- profile and header  ------------------
            CustomAppBar(text: "",
              height: coverHeight,
              flag: false,),
            Container(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pushNamed(context,RouteNames.userProfile_screen);
                     },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                         Row(
                           children: [
                             CircleAvatar(
                                 child: Icon(Icons.manage_accounts,
                                   color: AppColors.whiteColors,
                                 ),
                               backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Your Profile",style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: AppSizeClass.maxSize16,
                                 fontFamily: "NotoSerif",
                                 color:GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)

                               ),),
                             ),

                           ],
                         ),
                         IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                           onPressed: (){
                           Navigator.pushNamed(context,RouteNames.userProfile_screen);
                         },)
                         ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.supervised_user_circle,
                                  color: AppColors.whiteColors,),
                                backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Your Orders",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppSizeClass.maxSize16,
                                  fontFamily: "NotoSerif",

                                ),),
                              ),

                            ],
                          ),
                          IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                            onPressed: (){
                              Navigator.pushNamed(context,RouteNames.allOrders_screen);
                            },)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,RouteNames.complete_address_screen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.supervised_user_circle,
                                    color: AppColors.whiteColors,),
                                  backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Address book",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizeClass.maxSize16,
                                    fontFamily: "NotoSerif",

                                  ),),
                                ),

                              ],
                            ),
                            IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                              onPressed: (){
                                Navigator.pushNamed(context,RouteNames.complete_address_screen);
                              },)

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,RouteNames.contactus_screen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.supervised_user_circle,
                                    color: AppColors.whiteColors,),
                                  backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Contact Us",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizeClass.maxSize16,
                                    fontFamily: "NotoSerif",
                                  ),),
                                ),

                              ],
                            ),
                            IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                              onPressed: (){
                                Navigator.pushNamed(context,RouteNames.contactus_screen);
                              },)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    GestureDetector(
                   onTap: () async{

                     Navigator.pushNamed(context!, RouteNames.changepassword_screen,);
                     },
                   child:  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             CircleAvatar(
                               child: Icon(Icons.supervised_user_circle,
                                 color: AppColors.whiteColors,),
                               backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(AppConstentData.changePassword,
                                 style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: AppSizeClass.maxSize16,
                                 fontFamily: "NotoSerif",
                               ),
                               ),
                             ),

                           ],
                         ),
                         IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                           onPressed: (){
                             Navigator.pushNamed(context,RouteNames.userProfile_screen);
                           },)
                       ],
                     ),
                   ),
                 ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,RouteNames.aboutus_screen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    child: Icon(Icons.contact_page,
                                      color: AppColors.whiteColors,
                                    ),
                                  backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("About Us",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizeClass.maxSize16,
                                    fontFamily: "NotoSerif",
                                    color: AppColors.blackColors

                                  ),),
                                ),

                              ],
                            ),
                            IconButton(icon:Icon(Icons.arrow_forward_ios_rounded),color: Colors.grey[400],
                              onPressed: (){
                                Navigator.pushNamed(context,RouteNames.aboutus_screen);
                              },)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DividerWidgets(),
                    //--------------------logout container --------------------------
                    GestureDetector(
                      onTap: () async{
                        DialogUtils.showCustomDialog(context,
                            title: AppConstentData.logout,
                            okBtnText: AppConstentData.ok,
                            cancelBtnText: AppConstentData.cancel,
                             okBtnFunction: () async {
                               GoogleSignIn _googleSignIn = GoogleSignIn();
                               bool isSignedIn = await _googleSignIn.isSignedIn();
                               _googleSignIn.signOut();
                               Navigator.pop(context);

                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.contact_page,
                                    color: AppColors.whiteColors,
                                  ),
                                  backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(AppConstentData.logout,style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSizeClass.maxSize16,
                                      fontFamily: "NotoSerif",
                                      color: AppColors.blackColors

                                  ),),
                                ),

                              ],
                            ),
                            IconButton(icon:Icon(Icons.logout_outlined),color: Colors.grey[400],
                              onPressed: () async{
                                DialogUtils.showCustomDialog(context,
                                    title: AppConstentData.logout,
                                    okBtnText: AppConstentData.ok,
                                    cancelBtnText: AppConstentData.cancel,
                                    okBtnFunction: () async {
                                      GoogleSignIn _googleSignIn = GoogleSignIn();
                                      bool isSignedIn = await _googleSignIn.isSignedIn();
                                      _googleSignIn.signOut();
                                      Navigator.pop(context);

                                    });
                              },)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ) ,
              )
          ],
        ),
      ),
    );
  }
  Widget datacgfgh() {
    return CircleAvatar(
      radius: circleHeight/2,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppSizeClass.maxSize25)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(ImageUrls.google_url),
              ],
            ),
          )
      ),
    );
  }
}
